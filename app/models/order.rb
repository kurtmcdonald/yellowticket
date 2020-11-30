class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :store, through: :item
  scope :checkout, -> { where(status: "checkout", collected: false ) }
  scope :accepted, -> { where(status: "accepted", collected: false ) }
end
