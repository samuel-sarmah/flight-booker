class Booking < ApplicationRecord
  has_many :passengers, inverse_of: :booking
  belongs_to :flight
end
