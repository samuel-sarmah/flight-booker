# Flight Booker

A full-featured flight booking application built with Ruby on Rails that demonstrates advanced form handling, nested attributes, email notifications, and multi-step booking flows.

## Features

### 1. Flight Search
- Search flights by departure airport, arrival airport, and date
- Select number of passengers (1-4)
- Real-time filtering of available flights
- Display flight details including:
  - Departure and arrival airports
  - Flight date and time
  - Flight duration

### 2. Flight Selection
- Browse search results in an organized table
- Select desired flight via radio button
- View comprehensive flight information before booking

### 3. Passenger Information
- Dynamic passenger form generation based on selected passenger count
- Add or remove passengers dynamically using Stimulus controllers
- Collect passenger details:
  - Full name
  - Email address
- Automatic ticket number generation for each passenger

### 4. Booking Confirmation
- Confirmation page displaying:
  - Flight details
  - All passenger information
  - Individual ticket numbers
- Email notifications sent to each passenger with:
  - Unique ticket number
  - Flight details
  - Direct link to view individual ticket

### 5. Email System
- Individual confirmation emails for each passenger
- HTML and text email versions
- Development email preview via `letter_opener_web`
- Accessible at `/letter_opener` in development mode

## Technical Stack

- **Ruby on Rails 8.0**
- **Ruby 3.4.2**
- **SQLite3** (development/test)
- **Stimulus** for JavaScript interactions
- **Action Mailer** for email notifications
- **letter_opener_web** for email preview in development

## Database Schema

### Airports
- `airport_name`: string
- `airport_code`: string (3-letter IATA code)

### Flights
- `departure_airport_id`: references airports
- `arrival_airport_id`: references airports
- `startdatetime`: datetime
- `flight_duration`: integer (minutes)

### Bookings
- `flight_id`: references flights

### Passengers
- `booking_id`: references bookings
- `name`: string
- `email`: string
- `ticket_number`: string (unique, auto-generated)

## Setup Instructions

1. **Clone the repository:**
   ```bash
   git clone git@github.com:samuel-sarmah/flight-booker.git
   cd flight-booker
   ```

2. **Install dependencies:**
   ```bash
   bundle install
   ```

3. **Setup database:**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **Start the server:**
   ```bash
   rails server
   ```

5. **Visit the application:**
   ```
   http://localhost:3000
   ```

6. **View sent emails (development only):**
   ```
   http://localhost:3000/letter_opener
   ```

## Seed Data

The application includes seed data with:
- 100+ airports from around the world
- 1,500+ flights evenly distributed across airports
- Flight dates ranging from tomorrow to 365 days in the future
- Realistic flight durations (60-720 minutes)

## Key Features Implementation

### Dynamic Passenger Management
Uses Stimulus controllers to:
- Add new passenger fields dynamically
- Remove passenger fields
- Automatically reindex form fields for proper Rails nested attributes submission

### Email Notifications
- Multipart emails (HTML + text)
- Personalized for each passenger
- Includes unique ticket number
- Direct link to view individual ticket details

### Form Handling
- Multi-step booking process
- GET requests for search (bookmarkable URLs)
- POST requests for booking creation
- Nested attributes for passengers
- Strong parameters for security

## Future Enhancements

Potential additions for a complete booking system:

- **Payment Integration:**
  - PayPal API via [paypal-express gem](https://github.com/nov/paypal-express)
  - Stripe Checkout integration
  - Credit card payment processing

- **Additional Features:**
  - User authentication and accounts
  - Booking history
  - Flight cancellations and modifications
  - Round-trip flights
  - Seat selection
  - PDF ticket generation
  - SMS notifications
  - Multi-language support

## Testing

```bash
# Run all tests
rails test

# Run specific test file
rails test test/models/passenger_test.rb
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is available as open source under the terms of the MIT License.

## Acknowledgments

- Part of [The Odin Project](https://www.theodinproject.com/) curriculum
- Built to practice advanced Rails forms and associations