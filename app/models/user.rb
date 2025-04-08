class User < ApplicationRecord
  has_many :rentals
  has_many :rented_bikes, through: :rentals, source: :bike

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Method to check if a user is an admin
  def admin?
    self.admin
  end
end
