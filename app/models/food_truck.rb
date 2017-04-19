class FoodTruck < ApplicationRecord
  belongs_to :menu, required: false
  belongs_to :contact, required: false

  validates :name, uniqueness: true
end
