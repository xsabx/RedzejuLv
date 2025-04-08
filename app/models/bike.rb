class Bike < ApplicationRecord
  has_many :rentals
  has_many :users, through: :rentals
  has_one_attached :image
end
