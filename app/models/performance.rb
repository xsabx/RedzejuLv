class Performance < ApplicationRecord
  has_many :seen_performances
has_many :users, through: :seen_performances
has_one_attached :poster
end
