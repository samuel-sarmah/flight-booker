class FlightsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @airport_options = Airport.all.order(:airport_code).map do |airport|
      [ "#{airport.airport_code} - #{airport.airport_name}", airport.id ]
    end
    @passenger_options = (1..9).map { |n| [ pluralize(n, "passenger"), n ] }

    if search_params.present?
      @flights = Flight.includes(:departure_airport, :arrival_airport)

      if params[:departure_airport_id].present?
        @flights = @flights.where(departure_airport_id: params[:departure_airport_id])
      end

      if params[:arrival_airport_id].present?
        @flights = @flights.where(arrival_airport_id: params[:arrival_airport_id])
      end

      if params[:startdatetime].present?
        @flights = @flights.where("DATE(startdatetime) = ?", params[:startdatetime])
      end

      @flights = @flights.order(:startdatetime).limit(20)
      
      # If no flights match, show available alternatives
      if @flights.empty?
        @available_flights = Flight.includes(:departure_airport, :arrival_airport)
                                   .where("startdatetime >= ?", Time.current)
                                   .order(:startdatetime)
                                   .limit(10)
      end
    else
      @flights = []
    end
  end

  private

  def search_params
    params.permit(:departure_airport_id, :arrival_airport_id, :startdatetime, :passengers, :commit)
  end
end
