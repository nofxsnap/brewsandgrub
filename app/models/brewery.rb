class Brewery < ApplicationRecord
  belongs_to :contact, required: false
  belongs_to :menu, required: false
  has_one :food_truck, required: false

  validates :name, uniqueness: true
end
