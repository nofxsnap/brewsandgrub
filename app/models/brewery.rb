class Brewery < ApplicationRecord
  attr_accessor :food_truck

  belongs_to :contact, required: false
  belongs_to :menu, required: false
  belongs_to :food_truck, required: false  
end
