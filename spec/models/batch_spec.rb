require 'rails_helper'

RSpec.describe Batch, type: :model do
  subject { Batch.new(id: '1234567', file_guid: 'GHTE') }
  it { should have_many(:parcels).dependent(:destroy) }
  it { should validate_presence_of :file_guid }
  it { should validate_length_of(:id).is_equal_to(7) }
  it { should validate_uniqueness_of(:id).case_insensitive }
  it { should validate_uniqueness_of(:file_guid) }
  it { should allow_value('1234567', '9999999').for(:id) }
  it { should_not allow_value('35124-14', '123456a').for(:id) }
end
