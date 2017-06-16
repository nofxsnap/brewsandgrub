require 'rails_helper'
require 'date'

RSpec.describe ThirtyEightStateParser do

  before(:all) do
    @brewery = create(:thirty_eight_state)
    @food_truck = create(:taco_town_truck)
  end

  before(:each) do
    @notifications = Notification.new

    # Use local copy of april 2017 schedule for testing
    @brewery.update_attribute(:remote_schedule_endpoint, "#{Rails.root}/spec/util/dataz/thirty8st=||YYYY-MM||")
  end

  describe '#test_the things' do
    it "should get food truck for the day and create a new food truck" do
      today = Date.new(2017,4,19)

      @notifications.add_notifications ThirtyEightStateParser.get_food_truck_for_date(@brewery, today)

      expect(@notifications.size).to be(1)

      @notification = @notifications.get_notifications.first
      expect(@notification).to start_with("New Food Truck!")

      food_truck_id = @notification.split(/:\s/).last
      food_truck = FoodTruck.find(food_truck_id)
      expect(food_truck.name.downcase).to start_with "Saucy".downcase
    end

    it "should have no food truck on this day" do
      today = Date.new(2017,4,17)

      @notifications.add_notifications ThirtyEightStateParser.get_food_truck_for_date(@brewery, today)

      @brewery.reload

      expect(@brewery.food_truck).to be(nil)

      @notification = @notifications.get_notifications.first
      expect(@notification).to start_with("Could not find a food truck name")
      expect(@notifications.size).to be(1)

    end

    it "should get food truck for the day and assign ref to existing food truck" do
      today = Date.new(2017,4,1)

      @notifications.add_notifications ThirtyEightStateParser.get_food_truck_for_date(@brewery, today)

      expect(@notifications.size).to be(0)
      expect(@brewery.food_truck).to eq(@food_truck)
    end
  end


    after(:all) do
      FoodTruck.all.each { |x| x.destroy! }
      @brewery.destroy!
    end
end
