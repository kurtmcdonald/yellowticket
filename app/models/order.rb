class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :store, through: :item
  scope :checkout, -> { where(status: "checkout", collected: false ) }
  scope :accepted, -> { where(status: "accepted", collected: false ) }
end

# when we save an order and attrribute changes to true then generate qr code
# qr code - attach it to the order - attribute qr code or picture attached (cloudinary)
