class AddTicketNumberToPassengers < ActiveRecord::Migration[8.0]
  def change
    add_column :passengers, :ticket_number, :string
  end
end
