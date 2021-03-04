class CreateParcels < ActiveRecord::Migration[5.2]
  def change
    create_table :parcels do |t|
      t.references :batch, type: :string, foreign_key: true
      t.string :company_code, limit: 4, null: false
      t.string :invoice_operation_number, limit: 9, null: false
      t.date :invoice_operation_date, null: false
      t.string :parcel_code, limit: 15, null: false
      t.integer :item_qty, null: false
      t.integer :parcel_price, null: false
    end
    add_index :parcels, :parcel_code
    add_index :parcels, :invoice_operation_number
  end
end
