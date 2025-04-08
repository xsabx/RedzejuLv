class Rental < ApplicationRecord
  belongs_to :bike
  belongs_to :user

  # Custom validations to ensure data integrity before saving a rental.
  validate :start_date_cannot_be_in_the_past, :end_date_cannot_be_before_start_date
  validate :bike_must_be_available

  private

  # Validation method to ensure the start date is not in the past.
  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end

  # Validation method to ensure the end date is not before the start date.
  def end_date_cannot_be_before_start_date
    if end_date.present? && end_date < start_date
      errors.add(:end_date, "can't be before the start date")
    end
  end

  # Validation method to check if the bike is available for the selected dates.
  def bike_must_be_available
    overlapping_rentals = Rental.where(bike_id: bike_id)
                                .where("start_date < ? AND end_date > ?", end_date, start_date)
    if overlapping_rentals.exists?
      errors.add(:base, "The bike is not available for the selected dates.")
    end
  end
end
