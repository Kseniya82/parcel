    # rand(1000000..9999999) .to_s
FactoryBot.define do
  sequence :file_guid do |n|
    "GUID#{n}"
  end
  factory :batch do
    file_guid
    id { rand(1000000..9999999) .to_s }
  end
end