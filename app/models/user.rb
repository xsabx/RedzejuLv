class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :seen_performances, dependent: :destroy
  has_many :performances, through: :seen_performances
  has_many :reviews, dependent: :destroy
end
