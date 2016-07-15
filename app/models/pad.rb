class Pad < ActiveRecord::Base
  belongs_to :user
  has_many :photos
  has_many :reservations

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  validates :property_type, presence: true
  validates :pad_type, presence: true
  validates :accommodate, presence: true
  validates :total_pad, presence: true
  validates :pad_name, presence: true, length: {maximum: 50}
  validates :summary, presence: true, length: {maximum: 500}
  validates :address, presence: true
  validates :photos, presence: true
  validates :price, presence: true

end
