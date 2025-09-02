# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Airport.delete_all
Flight.delete_all

# Airport seeds
airports = [
  [ "Sarmah International, SK", "SIN" ],
  [ "Atlanta GA", "ATL" ],
  [ "Beijing, CN", "PEK" ],
  [ "London, GB", "LHR" ],
  [ "Chicago, IL", "ORD" ],
  [ "Tokyo JP", "HND" ],
  [ "Los Angeles CA", "LAX" ],
  [ "Paris, FR", "CDG" ],
  [ "Dallas/FortWorth TX", "US" ],
  [ "Frankfurt DE", "FRA" ],
  [ "Hong Kong HK", "HKG" ],
  [ "Denver Co", "DEN" ],
  [ "Dubai AE", "DXB" ],
  [ "Jarkata ID", "CGK" ],
  [ "Amsterdam, NL", "AMS" ],
  [ "Madrid, ES", "MAD" ],
  [ "Bangkok, TH", "BKK" ],
  [ "New York, NY", "JFK" ],
  [ "Singapore, SG", "SIN" ],
  [ "Guangzhou, CN", "CAN" ],
  [ "Las Vegas, NV", "LAS" ],
  [ "Shanghai, CN", "PVG" ],
  [ "San Francisco, CA", "SFO" ],
  [ "Phoenix, AZ", "PHX" ],
  [ "Houston, TX", "IAH" ],
  [ "Charlotte, NC", "CLT" ],
  [ "Miami, FL", "MIA" ],
  [ "Munich, DE", "MUC" ],
  [ "Kuala Lumpur, MY", "KUL" ],
  [ "Rome, IT", "FCO" ],
  [ "Istanbul, TR", "IST" ],
  [ "Sydney, AU", "SYD" ],
  [ "Orlando, FL", "MCO" ],
  [ "Incheon, KR", "INC" ],
  [ "New Delhi, IN", "DEL" ],
  [ "Barcelona, ES", "BCN" ],
  [ "London, GB", "LGW" ],
  [ "Newark, NJ", "EWR" ],
  [ "Toronto, ON", "YYZ" ],
  [ "Shanghai, CN", "SHA" ],
  [ "Minneapolis, MN", "MSP" ],
  [ "Seattle, WA", "SEA" ],
  [ "Detroit, MI", "DTW" ],
  [ "Philadelphia, PA", "PHL" ],
  [ "Mumbai, IN", "BOM" ],
  [ "Sao Paulo, BR", "GRU" ],
  [ "Manila, PH", "MNL" ],
  [ "Chengdu, CN", "CTU" ],
  [ "Boston, MA", "BOS" ],
  [ "Shenzhen, CN", "SZX" ],
  [ "Melbourne, AU", "MEL" ],
  [ "Tokyo, JP", "NRT" ],
  [ "Paris, FR", "ORY" ],
  [ "Mexico City, MX", "MEX" ],
  [ "Moscow, RU", "DME" ],
  [ "Antalya, TR", "AYT" ],
  [ "Taipei, TW", "TPE" ],
  [ "Zurich, CH", "ZRH" ],
  [ "New York, NY", "LGA" ],
  [ "Fort Lauderdale, FL", "FLL" ],
  [ "Washington, DC", "IAD" ],
  [ "Palma De Mallorca, ES", "PMI" ],
  [ "Copenhagen, DK", "CPH" ],
  [ "Moscow, RU", "SVO" ],
  [ "Baltimore, MD", "BWI" ],
  [ "Kunming, CN", "KMG" ],
  [ "Vienna, AT", "VIE" ],
  [ "Oslo, NO", "OSL" ],
  [ "Jeddah, SA", "JED" ],
  [ "Brisbane, AU", "BNE" ],
  [ "Salt Lake City, UT", "SLC" ],
  [ "Dussedldorf, DE", "DUS" ],
  [ "Bogota, CO", "BOG" ],
  [ "Milan, IT", "MXP" ],
  [ "Johannesburg, ZA", "JNB" ],
  [ "Stockholm, SE", "ARN" ],
  [ "Manchester, GB", "MAN" ],
  [ "Chicago, IL", "MDW" ],
  [ "Washington, DC", "DCA" ],
  [ "Brussels, BE", "BRU" ],
  [ "Dublin, IE", "DUB" ],
  [ "Seoul, KR", "GMP" ],
  [ "Doha, QA", "DOH" ],
  [ "London, GB", "STN" ],
  [ "Hangzhou, CN", "HGH" ],
  [ "Jeju, KR", "CJU" ],
  [ "Vancouver, BC", "YVR" ],
  [ "Berlin, DE", "TXL" ],
  [ "San Diego, CA", "SAN" ],
  [ "Tampa, FL", "TPA" ],
  [ "Sao Paulo, BR", "CGH" ],
  [ "Brasilia, BR", "BSB" ],
  [ "Sapporo, JP", "CTS" ],
  [ "Xiamen, CN", "XMN" ],
  [ "Riyadh, SA", "RUH" ],
  [ "Fukuoka, JP", "FUK" ],
  [ "Rio De Janeiro, BR", "GIG" ],
  [ "Helsinki, FI", "HEL" ],
  [ "Lisbon, PT", "LIS" ],
  [ "Athens, GR", "ATH" ],
  [ "Entebbe International, UG", "EBB" ],
  [ "Auckland, NZ", "AKL" ]
]

airports.each do |name, code|
  Airport.create!(airport_name: name, airport_code: code)
end
puts "#{Airport.count} aiports created"

puts "Creating flights..."
# Generate random flights
airports = Airport.all
total_flights = 1500
flights_per_airport = (total_flights / airports.count.to_f).ceil

airports.each do |departure_airport|
  flights_per_airport.times do
    # Select a random airport that's different from departure
    arrival_airport = airports.where.not(id: departure_airport.id).sample

    # Generate random datetime between tomorrow and next month
    base_date = Date.today + rand(1..30)

    # Use specific hours and minutes
    hour = [ 7, 10, 14, 17, 20 ].sample
    minute = [ 0, 15, 30, 45 ].sample

    # Combine date with time
    random_time = base_date.to_time.change(hour: hour, min: minute)

    Flight.create!(
      departure_airport_id: departure_airport.id,
      arrival_airport_id: arrival_airport.id,
      startdatetime: random_time,
      flight_duration: rand(60...720)
    )
    print "." # progress indicator
  end
end

puts "#{Flight.count} flights created"
puts "Average flights per airport: #{Flight.count.to_f / Airport.count}"
