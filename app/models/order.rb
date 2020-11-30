class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
end

# when we save an order and attrribute changes to true then generate qr code
# qr code - attach it to the order - attribute qr code or picture attached (cloudinary)
