class FoodTruckCalendar < ApplicationRecord
  belongs_to :brewery, required: false
  belongs_to :food_truck, required: false
end
