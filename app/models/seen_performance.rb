class SeenPerformance < ApplicationRecord
  belongs_to :performance
  belongs_to :user

  # Validation to ensure that seen_at is not in the future
  validate :seen_at_cannot_be_in_the_future

  private

  def seen_at_cannot_be_in_the_future
    if seen_at.present? && seen_at > Time.current
      errors.add(:seen_at, "can't be in the future")
    end
  end
end
