class FileController < ApplicationController
  after_action :save_to_db, only: :upload
  def new; end

  def upload
    File.open(file_path, 'wb') do |file|
      file.write(uploaded_file.read)
    end
    render plain: 'file save', status: 200 if File.exist?(file_path)
    render plain: 'file not save', status: 404 unless File.exist?(file_path)
  end

  private

  def uploaded_file
    params[:file]
  end

  def file_path
    Rails.root.join('public', 'uploads', uploaded_file.original_filename)
  end

  def save_to_db
    CreateParcelsService.new(file_path).call if File.exist?(file_path)
  end
end
