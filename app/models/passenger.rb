class Passenger < ApplicationRecord
  before_create :generate_ticket_number

  validates :name, :email, presence: true

  belongs_to :booking

  private
    def generate_ticket_number
      self.ticket_number = SecureRandom.alphanumeric(10).upcase
    end
end
