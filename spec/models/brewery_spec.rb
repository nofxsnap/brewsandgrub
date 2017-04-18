require 'rails_helper'

RSpec.describe Brewery, type: :model do

  describe "#Test_FactoryGirl_Setup" do
    it "should demonstrate a factory girl fabricated model" do
      ltd = create(:living_the_dream)
      expect(ltd.name).to eq("Living the Dream")
    end
  end
end
