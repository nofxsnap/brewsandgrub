require 'rails_helper'

RSpec.describe LivingTheDreamParser do

  before(:all) do
    @brewery = create(:living_the_dream)
  end

  before(:each) do
    @notifications = Notification.new
  end

  describe '#test_the things' do
    it "should get food truck for the day and create a new food truck" do
      @notifications = Notification.new
      @brewery.update_attribute(:remote_schedule_endpoint, "#{Rails.root}/spec/util/ltd.htm")
      @notifications = LivingTheDreamParser.get_todays_food_truck(@brewery, @notifications)

      expect(@notifications.size).to be(1)

      @notification = @notifications.get_notifications.first
      expect(@notification).to start_with("New Food Truck!")

      food_truck_id = @notification.split(/:\s/).last
      food_truck = FoodTruck.find(food_truck_id)
      expect(food_truck).not_to be(nil)
    end
  end
end
