class PassengerMailer < ApplicationMailer
  default from: "sarmah@flight-booker.com"

  def confirmation_email
    @passenger = params[:passenger]
    @booking = params[:booking]
    @flight = @booking.flight
    @ticket_number = @passenger.ticket_number

    mail(to: @passenger.email,
         subject: "Flight Booking Confirmation - #{@flight.departure_airport.airport_code} to #{@flight.arrival_airport.airport_code}")
  end
end
