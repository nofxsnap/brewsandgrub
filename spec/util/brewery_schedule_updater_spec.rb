require 'rails_helper'

RSpec.describe BreweryScheduleUpdater do

  before(:each) do
    @brewery = create(:living_the_dream)
  end

  describe '#test_the things' do
    it "should get food truck for the day" do
      notifications = BreweryScheduleUpdater.update_all_breweries
    end
  end
end
