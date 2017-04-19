class AddEventHoursToBrewery < ActiveRecord::Migration[5.0]
  def change
    add_column :breweries, :event_hours, :string
  end
end
