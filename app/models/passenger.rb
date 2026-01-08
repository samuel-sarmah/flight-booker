class Passenger < ApplicationRecord
  before_create :generate_ticket_number

  belongs_to :booking

  validates :name, presence: true,
                   length: { minimum: 2, maximum: 100 },
                   format: { with: /\A[a-zA-Z\s'-]+\z/, message: "can only contain letters, spaces, hyphens, and apostrophes" }

  validates :email, presence: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  private
    def generate_ticket_number
      self.ticket_number = SecureRandom.alphanumeric(10).upcase
    end
end
