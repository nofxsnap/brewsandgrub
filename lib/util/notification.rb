class Notification
  def initialize
    @notification_list = Array.new
  end

  def add_notification(message)
    @notification_list << message
  end

  def get_first_notification
    @notification_list.shift
  end

  def get_last_notification
    @notification_list.pop
  end

  def any_notifications?
    !@notification_list.empty?
  end

end
