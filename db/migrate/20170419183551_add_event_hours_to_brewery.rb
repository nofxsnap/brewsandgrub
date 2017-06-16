class AddEventHoursToBrewery < ActiveRecord::Migration[5.0]
  def change
    add_column :breweries, :event_hours, :string
    add_reference :food_trucks, :brewery, foreign_key: true, optional: true
  end
end
