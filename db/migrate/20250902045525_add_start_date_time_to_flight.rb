class AddStartDateTimeToFlight < ActiveRecord::Migration[8.0]
  def change
    add_column :flights, :startdatetime, :datetime
  end
end
