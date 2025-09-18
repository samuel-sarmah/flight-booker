class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:fligh_id])
    @passenger_count = params[:passenger].to_i
    @booking = Booking.new(flight: @flight)
    @passenger_count.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to @booking, notice: "Your booking has been successfull!"
    else
      @flight = booking.flight
      @passenger_count = @booking.passengers.size
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def booking_params
    params.reequire(:booking).permit(:flight_id, passenger_attributes: [ :name, :email ])
  end
end
