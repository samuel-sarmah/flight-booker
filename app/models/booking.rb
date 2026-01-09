class Booking < ApplicationRecord
  belongs_to :flight
  has_many :passengers, inverse_of: :booking, dependent: :destroy

  accepts_nested_attributes_for :passengers, allow_destroy: true, reject_if: :all_blank

  validates :flight, presence: true
  validates :booking_reference, presence: true, uniqueness: true, if: :guest_checkout?
  validates :guest_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :guest_checkout?
  validates :phone, presence: true, format: { with: /\A[\+]?[1-9][\d]{0,15}\z/ }, if: :guest_checkout?
  validate :must_have_at_least_one_passenger

  before_validation :generate_booking_reference, if: :guest_checkout?

  private

  def must_have_at_least_one_passenger
    if passengers.empty? || passengers.all?(&:marked_for_destruction?)
      errors.add(:base, "A booking must have at least one passenger")
    end
  end

  def generate_booking_reference
    return if booking_reference.present?

    loop do
      self.booking_reference = SecureRandom.alphanumeric(6).upcase
      break unless Booking.exists?(booking_reference: booking_reference)
    end
  end
end
