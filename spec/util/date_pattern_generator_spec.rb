require 'rails_helper'
require 'date'

RSpec.describe DatePatternGenerator do

  describe "#test_the_date_parser" do
    before(:each) do
      @brewery = create(:living_the_dream)
      @grist   = create(:grist)
    end

    it "should parse a date for living the dream" do
      endpoint = DatePatternGenerator.generate_date_string_for_brewery(@brewery, Date.new(2017,4,20))
      expect(endpoint).to eq("http://livingthedreambrewing.com/events/?view=calendar&month=April-2017")
    end

    it "should parse a date for grist" do
      endpoint = DatePatternGenerator.generate_date_string_for_brewery(@grist, Date.new(2017,4,20))
      expect(endpoint).to eq("https://www.gristbrewingcompany.com/events/?date=4/20/2017")
    end

    it "should return nil because the pattern doesn't match anything" do
      @brewery.update_attribute(:remote_schedule_endpoint, "bleat")
      endpoint = DatePatternGenerator.generate_date_string_for_brewery(@brewery, Date.new(2011,1,11))
      expect(endpoint).to be_empty
    end

    after(:each) do
      @brewery.destroy!
    end
  end

end
