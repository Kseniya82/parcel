class CreateBatches < ActiveRecord::Migration[5.2]
  def change
    create_table :batches, id: false do |t|
      t.string :file_guid, null: false, uniqueness: true
      t.string :id, limit: 7, primary_key: true
      # t.decimal :id, precision: 7, scale: 0, primary_key: true
      t.boolean :status, default: true
      t.date :creation_date
      t.index :file_guid

      t.timestamps
    end
  end
end
