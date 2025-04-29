class Review < ApplicationRecord
  belongs_to :user
  belongs_to :performance

  validates :content, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :seen_at, presence: true
  validate :seen_at_cannot_be_in_future

  private

  def seen_at_cannot_be_in_future
    if seen_at.present? && seen_at > Time.current
      errors.add(:seen_at, "nevar būt nākotnē")
    end
  end
end 