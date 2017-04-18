require 'rails_helper'

RSpec.describe BreweryScheduleUpdater, type: :model do
  it "should get food truck for the day" do
    notification = BreweryScheduleUpdater.update_all_breweries
  end
end
