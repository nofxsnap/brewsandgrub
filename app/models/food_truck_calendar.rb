class FoodTruckCalendar < ApplicationRecord
  belongs_to :brewery
  belongs_to :food_truck
end
