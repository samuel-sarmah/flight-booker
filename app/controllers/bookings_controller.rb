class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:flight_id])
    @passenger_count = params[:passengers].to_i
    @booking = Booking.new(flight: @flight)

    # Check if this is a guest checkout
    if params[:guest] == "true"
      @booking.guest_checkout = true
    end

    @passenger_count.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      # Tell the PassengerMailer to send a confirmation email after save
      # Send an email to each passenger
      @booking.passengers.each do |passenger|
        PassengerMailer.with(passenger: passenger, booking: @booking).confirmation_email.deliver_later
      end

      redirect_to @booking, notice: "Your booking has been successful!"
    else
      @flight = @booking.flight
      @passenger_count = @booking.passengers.size
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    permitted = [ :flight_id, :guest_checkout, :guest_email, :phone, passengers_attributes: [ :name, :email ] ]
    params.require(:booking).permit(permitted)
  end
end
