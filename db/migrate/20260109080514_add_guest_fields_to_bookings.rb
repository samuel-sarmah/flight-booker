class AddGuestFieldsToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :guest_email, :string
    add_column :bookings, :phone, :string
    add_column :bookings, :guest_checkout, :boolean, default: false

    add_index :bookings, :guest_email
  end
end
