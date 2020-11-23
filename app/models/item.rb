class Item < ApplicationRecord
  belongs_to :store
  has_many :orders
end
