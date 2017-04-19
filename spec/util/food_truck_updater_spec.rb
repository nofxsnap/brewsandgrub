require 'rails_helper'

RSpec.describe FoodTruckUpdaterSpec do

  before(:each) do
    @brewery = create(:living_the_dream)
    @food_truck = create(:taco_town_truck)
  end

  describe '#add_existing_reference_to_brewery' do
    it "should assign living the dream the taco town truck" do
      FoodTruckUpdater.update_brewery_with_truck(@brewery, food_truck_name, notifications)
      expect(@brewery.food_truck_id).to eq(@food_truck.id)
    end

    it "should assign living the dream a new food truck" do
      FoodTruckUpdater.update_brewery_with_truck(@brewery, food_truck_name, notifications)

      # Assume that the latest created food truck will be the new one
      new_food_truck = FoodTruck.order("created_at").last

      expect(@brewery.food_truck_id).to eq(new_food_truck.id)
    end
  end
end
