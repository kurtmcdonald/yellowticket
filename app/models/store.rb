class Store < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy
  has_many :orders, through: :items
end
