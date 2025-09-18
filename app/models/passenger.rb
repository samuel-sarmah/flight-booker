class Passenger < ApplicationRecord
  validate :name, :email, presence: true
  belongs_to :booking
end
