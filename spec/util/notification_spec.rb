require 'rails_helper'

RSpec.describe Notification do

  SPEC_NOTIFICATION_ONE_TEXT = "The data was malformed."
  SPEC_NOTIFICATION_TWO_TEXT = "Collect all errors before failing."
  SPEC_NOTIFICATION_THREE_TEXT = "Get all errors when parsing data before failing."

  notification = Notification.new
  notification.add_notification(SPEC_NOTIFICATION_ONE_TEXT)
  notification.add_notification(SPEC_NOTIFICATION_TWO_TEXT)
  notification.add_notification(SPEC_NOTIFICATION_THREE_TEXT)

  describe "#no_notifications" do
    it "should return no notifications because everything is awesome" do
      blank = Notification.new
      expect(blank.any_notifications?).to eq(false)
    end
  end

  describe "#some_notifications" do
    it "should return that there are notifications because something happened" do
      expect(notification.any_notifications?).to eq(true)
    end
  end

  describe "#list_notifications" do
    it "should return each notification first to last" do
      notification_list = notification.get_notifications
      expect(notification_list[0]).to eq(SPEC_NOTIFICATION_ONE_TEXT)
      expect(notification_list[1]).to eq(SPEC_NOTIFICATION_TWO_TEXT)
      expect(notification_list[2]).to eq(SPEC_NOTIFICATION_THREE_TEXT)
    end
  end
end
