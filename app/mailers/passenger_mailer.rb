class PassengerMailer < ApplicationMailer
  default from: "notifications@flight-booker.com"

  def confirmation_email
    @passenger = params[:passenger]
    mail(to: @passenger.email, subject: "You booking has been confirmed")
  end
end
