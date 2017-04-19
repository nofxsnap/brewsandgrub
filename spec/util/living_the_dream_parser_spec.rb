require 'rails_helper'

RSpec.describe LivingTheDreamParser do

  before(:each) do
    @brewery = create(:living_the_dream)
  end

  describe '#test_the things' do
    it "should get food truck for the day" do
      notifications = Notification.new
      notifications = LivingTheDreamParser.get_todays_food_truck(@brewery, notifications)
    end
  end
end
