class Parcel < ApplicationRecord
  belongs_to :batch

  validates :parcel_code, 
            :invoice_operation_number,
            :company_code,
            :invoice_operation_date,
            :parcel_price,
            :item_qty,
            presence: true
  validates :invoice_operation_number, length: { maximum: 9 }
  validates :company_code, length: { is: 4 }
  validates :parcel_code, length: { is: 15 }
  validates :parcel_price, 
             numericality: { only_integer: true, 
                             greater_than: 0,
                             less_than_or_equal_to: 90000 }
  validates  :item_qty, numericality: { only_integer: true, 
                                       greater_than: 0,
                                      less_than_or_equal_to: 50 }
  validate :validate_count_product, on: :create

  private
  # кол-во товаров в одной посылке от 1 до 10, меньше 1 нам не даст сделать
  # валидация presence: true и null: false в миграции, поэтому добавляем ошибку, если больше 10
  def validate_count_product
    errors.add(:base) if count_product_in_current_parcel > 10
  end

  def count_product_in_current_parcel
    byebug
    self.class.where(invoice_operation_number: self.invoice_operation_number).count
  end
end
