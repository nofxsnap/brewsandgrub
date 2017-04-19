require 'rails_helper'

RSpec.describe FoodTruckUpdater do

  before(:all) do
    @brewery = create(:living_the_dream)
    @food_truck = create(:taco_town_truck)
  end

  before(:each) do
    @notifications = Notification.new
  end

  describe '#add_existing_reference_to_brewery' do
    it "should assign living the dream the taco town truck" do
      food_truck_name = @food_truck.name

      FoodTruckUpdater.update_brewery_with_truck(@brewery, food_truck_name, @notifications)
      expect(@brewery.food_truck).to eq(@food_truck)
      expect(@notifications.any_notifications?).to eq(false)
    end

    it "should assign living the dream a new food truck" do
      food_truck_name = "wally world of wangs and thangs"

      FoodTruckUpdater.update_brewery_with_truck(@brewery, food_truck_name, @notifications)

      # Assume that the latest created food truck will be the new one
      new_food_truck = FoodTruck.order("created_at").last

      expect(@brewery.food_truck).to eq(new_food_truck)
      expect(@notifications.any_notifications?).to eq(true)
    end
  end
end
