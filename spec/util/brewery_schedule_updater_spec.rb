require 'rails_helper'

RSpec.describe BreweryScheduleUpdater do
  SPEC_BREWERY_EVENT_HOURS = "4:00pm-8:00pm"
  SPEC_BREWERY_LONG_EVENT_HOURS = "1:00pm-8:00pm"

  before(:all) do
    @living_the_dream = create(:living_the_dream)
    @food_truck = create(:taco_town_truck)
  end

  before(:each) do
    @notifications = Notification.new
  end


  describe '#test_the things' do
    it "should get existing food truck for the given day" do
      today = Date.new(2017,4,19)

      @living_the_dream.update_attribute(:remote_schedule_endpoint, "#{Rails.root}/spec/util/dataz/ltd?view=calendar&month=||MONTH-YYYY||")

      @notifications.add_notifications BreweryScheduleUpdater.update_all_breweries(today)

      @living_the_dream.reload
      @food_truck.reload

      expect(@notifications.size).to eq(0)
      expect(@living_the_dream.food_truck).to eq(@food_truck)
      expect(@living_the_dream.event_hours).to eq(SPEC_BREWERY_EVENT_HOURS)
    end

    it "should get a new food truck for the given day" do
      today = Date.new(2017,4,30)

      @notifications.add_notifications BreweryScheduleUpdater.update_all_breweries(today)

      @living_the_dream.reload

      new_food_truck = FoodTruck.order("created_at").last

      expect(@notifications.size).to eq(1)
      expect(@living_the_dream.food_truck).to eq(new_food_truck)
      expect(@living_the_dream.event_hours).to eq(SPEC_BREWERY_LONG_EVENT_HOURS)
    end

    it 'should get all food trucks for all breweries for the given day' do
      today = Date.new(2017,4,26)
      @resolute         = create(:resolute)
      @lone_tree        = create(:lone_tree)
      @thirty_eight     = create(:thirty_eight_state)
      @grist            = create(:grist)

      # Update required endpoints to refer to the local file for testing purposes
      @living_the_dream.update_attribute(:remote_schedule_endpoint, "#{Rails.root}/spec/util/dataz/ltd?view=calendar&month=||MONTH-YYYY||")
      @resolute.update_attribute(:remote_schedule_endpoint, "#{Rails.root}/spec/util/dataz/resolute.html")
      @thirty_eight.update_attribute(:remote_schedule_endpoint, "#{Rails.root}/spec/util/dataz/thirty8st=||YYYY-MM||")
      @lone_tree.update_attribute(:remote_schedule_endpoint, "#{Rails.root}/spec/util/dataz/lonetree.html")

      # grist is still a live pull, dangit

      @notifications.add_notifications BreweryScheduleUpdater.update_all_breweries(today)

      expect(@notifications.size).to eq(5) # One notifiaction for each new food truck
      @notifications.get_notifications.each do |n|
        expect(n).to start_with("New Food Truck")
      end

      @lone_tree.reload
      expect(@lone_tree.food_truck).not_to be(nil)
      expect(@lone_tree.food_truck.name).to eq ("Denver 808/Ohana Denver")

      @resolute.reload
      expect(@resolute.food_truck).not_to be(nil)
      expect(@resolute.food_truck.name).to eq ("Ol' Skool Que")

      @grist.reload
      expect(@grist.food_truck).not_to be(nil)
      expect(@grist.food_truck.name).to eq ("Mile High Cajun")

      @thirty_eight.reload
      expect(@thirty_eight.food_truck).not_to be(nil)
      expect(@thirty_eight.food_truck.name).to eq("Saucy Buns BBQ")

      @living_the_dream.reload
      expect(@living_the_dream.food_truck).not_to be(nil)
      expect(@living_the_dream.food_truck.name).to eq("Go'n South")
    end
  end

  after(:all) do
    FoodTruck.all.each { |x| x.destroy! }
    Brewery.all.each { |b| b.destroy! }
  end
end
