class PassengerMailer < ApplicationMailer
  default from: "notifications@flight-booker.com"

  def confirmation_email
    @passenger = params[:passenger]
    @booking = params[:booking]
    @flight = @booking.flight

    mail(to: @passenger.email,
         subject: "Flight Booking Confirmation - #{@flight.departure_airport.airport_code} to #{@flight.arrival_airport.airport_code}")
  end
end
