require 'rails_helper'

RSpec.describe BreweryScheduleUpdater do
  SPEC_BREWERY_EVENT_HOURS = "4:00pm-8:00pm"
  SPEC_BREWERY_LONG_EVENT_HOURS = "1:00pm-8:00pm"

  before(:all) do
    @brewery = create(:living_the_dream)
    @food_truck = create(:taco_town_truck)
  end

  before(:each) do
    @notifications = Notification.new
  end


  describe '#test_the things' do
    it "should get existing food truck for the given day" do
      today = Date.new(2017,4,19)

      @brewery.update_attribute(:remote_schedule_endpoint, "#{Rails.root}/spec/util/dataz/ltd?view=calendar&month=||MONTH-YYYY||")

      @notifications.add_notifications BreweryScheduleUpdater.update_all_breweries(today)

      @brewery.reload
      @food_truck.reload

      expect(@notifications.size).to eq(0)
      expect(@brewery.food_truck).to eq(@food_truck)
      expect(@brewery.event_hours).to eq(SPEC_BREWERY_EVENT_HOURS)
    end

    it "should get a new food truck for the given day" do
      today = Date.new(2017,4,30)

      @notifications.add_notifications BreweryScheduleUpdater.update_all_breweries(today)

      @brewery.reload

      new_food_truck = FoodTruck.order("created_at").last

      expect(@notifications.size).to eq(1)
      expect(@brewery.food_truck).to eq(new_food_truck)
      expect(@brewery.event_hours).to eq(SPEC_BREWERY_LONG_EVENT_HOURS)
    end
  end

  after(:all) do
    FoodTruck.all.each { |x| x.destroy! }
    @brewery.destroy!
  end
end
