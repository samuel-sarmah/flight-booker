# ✈️ Flight Booker

A beautiful, Apple-inspired flight booking app built with Ruby on Rails and Hotwire (Turbo + Stimulus). Book your flight in 3 easy steps!

![Ruby](https://img.shields.io/badge/Ruby-3.4.2-red)
![Rails](https://img.shields.io/badge/Rails-8.0-red)
![License](https://img.shields.io/badge/License-MIT-blue)

## 🎯 How It Works

Booking a flight is super easy - just 3 steps:

### Step 1: Search Flights
- Pick where you're flying **from** and **to**
- Choose your travel date
- Select how many passengers (1-9 people)
- Click "Search Flights"

### Step 2: Choose Your Flight
- Browse the available flights
- See departure/arrival times, duration, and price
- Click on a flight card to select it
- Click "Continue to Passengers"

### Step 3: Enter Passenger Details
- Fill in names and emails for each passenger
- Add more passengers with the "Add Passenger" button
- Click "Confirm Booking"
- 🎉 Done! Everyone gets a confirmation email!

## ✨ Features

- **Beautiful Design** - Clean, Apple-inspired interface
- **Real-time Validation** - See errors as you type
- **Dynamic Forms** - Add/remove passengers instantly
- **Email Confirmations** - Each passenger gets their ticket
- **Mobile Friendly** - Works great on phones and tablets
- **Fast & Smooth** - Hotwire makes everything snappy

## 🚀 Getting Started

### Prerequisites
- Ruby 3.4.2
- Rails 8.0
- SQLite3

### Setup

1. **Clone the repo**
   \`\`\`bash
   git clone https://github.com/yourusername/flight-booker.git
   cd flight-booker
   \`\`\`

2. **Install dependencies**
   \`\`\`bash
   bundle install
   \`\`\`

3. **Set up the database**
   \`\`\`bash
   bin/rails db:create db:migrate db:seed
   \`\`\`

4. **Start the server**
   \`\`\`bash
   bin/rails server
   \`\`\`

5. **Open your browser**
   Go to [http://localhost:3000](http://localhost:3000)

### View Emails (Development)
In development, emails don't actually send - they open in your browser!
Visit [http://localhost:3000/letter_opener](http://localhost:3000/letter_opener) to see all sent emails.

## 📁 Project Structure

\`\`\`
app/
├── assets/stylesheets/     # Apple-inspired CSS design system
├── controllers/            # Rails controllers
├── javascript/controllers/ # Stimulus controllers for interactivity
├── models/                 # Flight, Booking, Passenger, Airport
├── views/                  # ERB templates with Turbo
└── mailers/                # Passenger confirmation emails

db/
├── seeds.rb               # 70 airports, 90 days of flights
└── migrate/               # Database migrations
\`\`\`

## 🔧 Tech Stack

| Technology | Purpose |
|------------|---------|
| Ruby on Rails 8 | Backend framework |
| Hotwire (Turbo + Stimulus) | Modern frontend without heavy JavaScript |
| SQLite3 | Database |
| Letter Opener | Email preview in development |

## 🧪 Running Tests

\`\`\`bash
bin/rails test
\`\`\`

## 📝 Validation Rules

**Passengers must have:**
- Name: 2+ characters, letters/spaces/hyphens only
- Email: Valid email format

**Bookings must have:**
- At least 1 passenger
- A valid flight selected

## 🎨 Design Philosophy

The app follows Apple's Human Interface Guidelines:
- Clean, minimalist design
- Subtle shadows and rounded corners
- Smooth animations and transitions
- Clear visual hierarchy
- Mobile-first responsive layout

## 📄 License

MIT License - see [LICENSE](LICENSE) for details.

---

Made with ❤️ using Ruby on Rails
