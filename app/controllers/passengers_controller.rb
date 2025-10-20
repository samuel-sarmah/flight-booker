class PassengersController < ApplicationController
  def show
    @booking = Booking.find(params[:booking_id])
    @passenger = @booking.passengers.find(params[:id])
    @flight = @booking.flight
  end
end
