class Item < ApplicationRecord
  belongs_to :store
  has_many :orders, dependent: :destroy
  has_one_attached :photo
end
