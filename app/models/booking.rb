class Booking < ApplicationRecord
  has_many :passengers, inverse_of: :booking
  belongs_to :flight

  accepts_nested_attributes_for :passengers, allow_destroy: true
end
