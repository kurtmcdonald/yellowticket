class Store < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :orders, through: :items, dependent: :destroy
end
