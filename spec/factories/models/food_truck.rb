# Factory girl instance for breweries
FactoryGirl.define do
  factory :taco_town_truck, class: FoodTruck do
    name "Taco Town:  The Truck"
    email "tacotowntruck@tacotown.mx"
    website "http://whowantstacos.com/lordbusiness"
  end
end
