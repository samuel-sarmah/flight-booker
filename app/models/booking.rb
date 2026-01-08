class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passengers, inverse_of: :booking, dependent: :destroy

  accepts_nested_attributes_for :passengers, allow_destroy: true, reject_if: :all_blank

  validates :flight, presence: true
  validate :must_have_at_least_one_passenger

  private

  def must_have_at_least_one_passenger
    if passengers.empty? || passengers.all?(&:marked_for_destruction?)
      errors.add(:base, "A booking must have at least one passenger")
    end
  end
end
