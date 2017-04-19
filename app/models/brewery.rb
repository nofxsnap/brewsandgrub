class Brewery < ApplicationRecord
  attr_accessor :food_truck_id

  belongs_to :contact, required: false
  belongs_to :menu, required: false
  has_one :food_truck
end
