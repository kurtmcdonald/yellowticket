class Store < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :orders, through: :items, dependent: :destroy
  has_one_attached :photo
  # validates :bio, length: { maximum: 200,
  #   too_long: "%{count} characters is the maximum allowed for your store description" }
  # validates :name, :address, :description, presence: true

  acts_as_taggable_on :tags

  include PgSearch::Model
  pg_search_scope :search_field,
    against: [ :name, :address ],
    associated_against: {
      items: [ :name ]
    },
    using: {
      tsearch: { prefix: true }
    }
end

