class CreateParcelsService
  LOGGER_FILE = "#{Rails.root}/log/create_parcels_service.log"
  LOGGER      = Logger.new(LOGGER_FILE)
  
  attr_reader :file_path, :data_hash, :batch

  def initialize(file_path)
    @file_path = file_path
  end

  def call
    xml_to_models
  end

  private

  def xml_to_models
    parser = Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
    @data_hash = parser.parse(File.read(file_path))
    file_guid = data_hash.dig(:root, :file_attribute, :guid)
    return if Batch.find_by(file_guid: file_guid)
    create_batch
    if batch.errors.present?
      Logger.info "Batch not created: #{batch.errors}"
    else
      create_parcels
    end
    rescue ActiveRecord::RecordInvalid
    parcels_count = batch.parcels.count
    LOGGER.info 'Bad file content' if parcels_count == 0
    batch.update!(status: false)
    LOGGER.info '============================================================'
  end

  def create_batch
    creation_date = Date.parse(data_hash.dig(:root, :file_data, :batch, :creation_date))
    @batch = Batch.create!(
      file_guid:      data_hash.dig(:root, :file_attribute, :guid),
      id:             data_hash.dig(:root, :file_data, :batch, :batch_id),
      creation_date:  data_hash.dig(:root, :file_data, :batch, :creation_date)
    )
  end

  def create_parcels
    ActiveRecord::Base.transaction do
      data_hash.dig(:root, :file_data, :invoice).each do |data_parcel|
        #преобразуем в массив, если товар в посылке 1 и избавляемся от вложенности
        [data_parcel.dig(:invoice_data)].flatten.each do |data_product|
          invoice_operation = data_parcel.dig(:invoice_operation)
          invoice_operation_date = Date.parse(invoice_operation.dig(:invoice_operation_date))
          Parcel.create!(
            batch_id:                 batch.id,
            company_code:             invoice_operation.dig(:company_code),
            invoice_operation_number: invoice_operation.dig(:invoice_operation_number),
            invoice_operation_date:   invoice_operation_date,
            parcel_code:              data_product.dig(:parcel_code),
            item_qty:                 data_product.dig(:item_qty),
            parcel_price:             data_product.dig(:parcel_price)
          )
        end
      end
    end
  end
end