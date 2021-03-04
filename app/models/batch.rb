class Batch < ApplicationRecord
  has_many :parcels, dependent: :destroy

  validates :file_guid, presence: :true
  validates :file_guid, :id, uniqueness: true
  validates :id, length: { is: 7 }
  validates :id, format:  /\A\d+\z/ 
  validates_associated :parcels
end
