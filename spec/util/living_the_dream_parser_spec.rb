require 'rails_helper'
require 'date'

RSpec.describe LivingTheDreamParser do
  SPEC_BREWERY_EVENT_HOURS = "4:00pm-8:00pm"

  before(:all) do
    @brewery = create(:living_the_dream)
    @food_truck = create(:taco_town_truck)
  end

  before(:each) do
    @notifications = Notification.new

    # Use local copy of april 2017 schedule for testing
    @brewery.update_attribute(:remote_schedule_endpoint, "#{Rails.root}/spec/util/dataz/ltd?view=calendar&month=||MONTH-YYYY||")
  end

  describe '#test_the things' do
    it "should get food truck for the day and create a new food truck" do
      today = Date.new(2017,4,17)

      @notifications.add_notifications LivingTheDreamParser.get_food_truck_for_date(@brewery, today)

      expect(@notifications.size).to be(1)

      @notification = @notifications.get_notifications.first
      expect(@notification).to start_with("New Food Truck!")

      food_truck_id = @notification.split(/:\s/).last
      food_truck = FoodTruck.find(food_truck_id)
      expect(food_truck).not_to be(nil)

      expect(@brewery.event_hours).to eq(SPEC_BREWERY_EVENT_HOURS)
    end

    it "should get food truck for the day and assign ref to existing food truck" do
      today = Date.new(2017,4,19)

      @notifications.add_notifications LivingTheDreamParser.get_food_truck_for_date(@brewery, today)

      expect(@notifications.size).to be(0)

      expect(@brewery.food_truck).to eq(@food_truck)

      expect(@brewery.event_hours).to eq(SPEC_BREWERY_EVENT_HOURS)
    end
  end


    after(:all) do
      FoodTruck.all.each { |x| x.destroy! }
      @brewery.destroy!
    end
end
