class FlightsController < ApplicationController
  def index
    @airport_options = Airport.all.map { |airport|  [ airport.airport_code, airport.id ] }
    @passenger_options = (1..4)

    if search_params.present?
      @flights = Flight.all
      if params[:departure_airport_id].present?
        @flights = @flights.where(departure_airport_id: params[:departure_airport_id])
      end

      if params[:arrival_airport_id].present?
        @flights = @flights.where(arrival_airport_id: params[:arrival_airport_id])
      end

      if params[:startdatetime].present?
        @flights = @flights.where("DATE(startdatetime) = ?", params[:startdatetime])
      end
    else
      @flights = []
    end
  end

  private

  def search_params
    params.permit(:departure_airport_id, :arrival_airport_id, :startdatetime)
  end
end
