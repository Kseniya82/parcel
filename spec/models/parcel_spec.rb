require 'rails_helper'

RSpec.describe Parcel, type: :model do
  it { should belong_to :batch }
  it { should validate_presence_of :parcel_code }
  it { should validate_presence_of :invoice_operation_number }
  it { should validate_presence_of :company_code }
  it { should validate_presence_of :invoice_operation_date }
  it { should validate_presence_of :parcel_price }
  it { should validate_presence_of :item_qty }
  
  it { should validate_length_of(:invoice_operation_number).is_at_most(9) }
  it { should validate_length_of(:company_code).is_equal_to(4) }
  it { should validate_length_of(:parcel_code).is_equal_to(15) }
  
  it { should validate_numericality_of(:parcel_price).only_integer }
  it { should validate_numericality_of(:parcel_price).is_greater_than(0) }
  it { should validate_numericality_of(:parcel_price).is_less_than_or_equal_to(90000) }

  it { should validate_numericality_of(:item_qty).only_integer }
  it { should validate_numericality_of(:item_qty).is_greater_than(0) }
  it { should validate_numericality_of(:item_qty).is_less_than_or_equal_to(50) }
end
