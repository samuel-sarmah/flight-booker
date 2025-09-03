class FlightsController < ApplicationController
  def index
    @airport_options = Airport.all.map { |airport| [ airport.airport_name, airport.airport_code ] }
    @passenger_options = (1..4)

    @flights = Flight.all
    if params[:search]
      @flight = @flights.where(departure_airport_id: params[:departure_airport_id]) if params[:departure_airport_id].present?
      @flight = @flights.where(arrival_airport_id: params[:arrival_airport_id]) if params[:arrival_airport_id].present?
      @flights = @flights.where("Date(startdatetime) = ?", params[:startdatetime]) if params[:startdatetime].present?
    end
  end
end
