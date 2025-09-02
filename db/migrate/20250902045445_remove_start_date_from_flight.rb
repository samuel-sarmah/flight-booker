class RemoveStartDateFromFlight < ActiveRecord::Migration[8.0]
  def change
    remove_column :flights, :start_datetime, :date
  end
end
