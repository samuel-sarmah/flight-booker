class AddPassengerToBookings < ActiveRecord::Migration[8.0]
  def change
    add_reference :bookings, :passenger, null: false, foreign_key: true
  end
end
