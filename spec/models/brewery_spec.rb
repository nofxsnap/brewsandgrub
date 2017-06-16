require 'rails_helper'

RSpec.describe Brewery, type: :model do

  describe "#Test_FactoryGirl_Setup" do
    it "should demonstrate a factory girl fabricated model" do
      ltd = create(:living_the_dream)
      expect(ltd.name).to eq("Living the Dream")
    end
  end

  describe "#get_todays_food_truck_from_file" do
    it "should get food truck for the day" do
      notification = BreweryScheduleUpdater.update_all_breweries
    end
  end
end
