require 'rails_helper'

RSpec.describe Notification do

  describe "#no_notifications" do
    it "should return no notifications because everything is awesome" do
      notification = Notification.new
      expect(notification.any_notifications?).to eq(false)
    end
  end

end
