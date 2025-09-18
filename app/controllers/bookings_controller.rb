class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:fligh_id])
    @passenger_count = params[:passenger].to_i
    @booking = Booking.new(flight: @flight)
    @passenger_count.times { @booking.passengers.build }
  end

  def create
  end

  def show
  end
end
