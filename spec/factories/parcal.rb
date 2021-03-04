FactoryBot.define do
  factory :parcel do
    batch
    parcel_code { rand(100000000000000..999999999999999).to_s }
    invoice_operation_number { '12366434' }
    company_code { rand(1000..9999).to_s }
    invoice_operation_date { Date.today }
    parcel_price { rand(1..90000) } 
    item_qty { rand(1..50) } 
  end
end