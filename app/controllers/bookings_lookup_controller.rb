class BookingsLookupController < ApplicationController
  def new
    # Display lookup form
  end

  def show
    reference = params[:reference]&.upcase&.strip
    email = params[:email]&.downcase&.strip

    if reference.blank? || email.blank?
      flash.now[:alert] = "Please enter both booking reference and email address"
      render :new and return
    end

    unless BookingLookup.validate_reference_format(reference)
      flash.now[:alert] = "Please enter a valid 6-character booking reference"
      render :new and return
    end

    @booking = BookingLookup.find_by_reference_and_email(reference, email)

    if @booking
      redirect_to @booking, notice: "Booking found successfully!"
    else
      flash.now[:alert] = "No booking found with that reference and email combination"
      render :new
    end
  end

  private

  def lookup_params
    params.permit(:reference, :email)
  end
end
