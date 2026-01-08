# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Clearing existing data..."
Passenger.delete_all
Booking.delete_all
Flight.delete_all
Airport.delete_all

# Airport seeds - Major international airports
airports = [
  [ "Atlanta, GA", "ATL" ],
  [ "Beijing, CN", "PEK" ],
  [ "London Heathrow, GB", "LHR" ],
  [ "Chicago O'Hare, IL", "ORD" ],
  [ "Tokyo Haneda, JP", "HND" ],
  [ "Los Angeles, CA", "LAX" ],
  [ "Paris Charles de Gaulle, FR", "CDG" ],
  [ "Dallas/Fort Worth, TX", "DFW" ],
  [ "Frankfurt, DE", "FRA" ],
  [ "Hong Kong", "HKG" ],
  [ "Denver, CO", "DEN" ],
  [ "Dubai, AE", "DXB" ],
  [ "Jakarta, ID", "CGK" ],
  [ "Amsterdam, NL", "AMS" ],
  [ "Madrid, ES", "MAD" ],
  [ "Bangkok, TH", "BKK" ],
  [ "New York JFK, NY", "JFK" ],
  [ "Singapore", "SIN" ],
  [ "Guangzhou, CN", "CAN" ],
  [ "Las Vegas, NV", "LAS" ],
  [ "Shanghai Pudong, CN", "PVG" ],
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
  [ "Seoul Incheon, KR", "ICN" ],
  [ "New Delhi, IN", "DEL" ],
  [ "Barcelona, ES", "BCN" ],
  [ "London Gatwick, GB", "LGW" ],
  [ "Newark, NJ", "EWR" ],
  [ "Toronto, CA", "YYZ" ],
  [ "Minneapolis, MN", "MSP" ],
  [ "Seattle, WA", "SEA" ],
  [ "Detroit, MI", "DTW" ],
  [ "Philadelphia, PA", "PHL" ],
  [ "Mumbai, IN", "BOM" ],
  [ "São Paulo, BR", "GRU" ],
  [ "Manila, PH", "MNL" ],
  [ "Boston, MA", "BOS" ],
  [ "Melbourne, AU", "MEL" ],
  [ "Tokyo Narita, JP", "NRT" ],
  [ "Mexico City, MX", "MEX" ],
  [ "Taipei, TW", "TPE" ],
  [ "Zurich, CH", "ZRH" ],
  [ "New York LaGuardia, NY", "LGA" ],
  [ "Fort Lauderdale, FL", "FLL" ],
  [ "Washington Dulles, DC", "IAD" ],
  [ "Copenhagen, DK", "CPH" ],
  [ "Vienna, AT", "VIE" ],
  [ "Oslo, NO", "OSL" ],
  [ "Brisbane, AU", "BNE" ],
  [ "Salt Lake City, UT", "SLC" ],
  [ "Milan, IT", "MXP" ],
  [ "Johannesburg, ZA", "JNB" ],
  [ "Stockholm, SE", "ARN" ],
  [ "Manchester, GB", "MAN" ],
  [ "Chicago Midway, IL", "MDW" ],
  [ "Brussels, BE", "BRU" ],
  [ "Dublin, IE", "DUB" ],
  [ "Doha, QA", "DOH" ],
  [ "Auckland, NZ", "AKL" ],
  [ "Lisbon, PT", "LIS" ],
  [ "Vancouver, CA", "YVR" ]
]

puts "Creating airports..."
airports.each do |airport_name, airport_code|
  Airport.create!(airport_name: airport_name, airport_code: airport_code)
end
puts "✓ #{Airport.count} airports created"

# Create flights for the next 90 days
puts "Creating flights..."
flight_count = 0
airport_ids = Airport.pluck(:id)

# Generate flights for each day
(Date.today..Date.today + 90.days).each do |date|
  # Create 5-10 random flights per day
  rand(5..10).times do
    departure_id = airport_ids.sample
    arrival_id = (airport_ids - [ departure_id ]).sample

    # Random departure time between 6 AM and 10 PM
    hour = rand(6..22)
    minute = [ 0, 15, 30, 45 ].sample
    departure_time = date.to_datetime + hour.hours + minute.minutes

    # Random flight duration between 1-12 hours
    duration = rand(60..720)

    Flight.create!(
      departure_airport_id: departure_id,
      arrival_airport_id: arrival_id,
      startdatetime: departure_time,
      flight_duration: duration
    )
    flight_count += 1
  end
end

puts "✓ #{flight_count} flights created"
puts "\n✅ Seeding complete!"
