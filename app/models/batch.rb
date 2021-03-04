class Batch < ApplicationRecord
  has_many :parcels

  validates :file_guid, presence: :true
  validates :file_guid, :id, uniqueness: true
  validates :id, length: { is: 7 }
  validates_associated :parcels
end
