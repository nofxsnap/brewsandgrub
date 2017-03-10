class CreateFoodTruckCalendars < ActiveRecord::Migration[5.0]
  def change
    create_table :food_truck_calendars do |t|
      t.references :brewery, foreign_key: true
      t.references :food_truck, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
