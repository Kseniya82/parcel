class Batch < ApplicationRecord
  has_many :parcers

  validates :file_guid, presence: :true
  validates :file_guid, :id, uniqueness: true
  validates :id, length: { is: 7 }
  validates_associated :parcers
end
