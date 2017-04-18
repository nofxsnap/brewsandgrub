class Notification
  # Simple Notification container to implement a basic notification pattern.
  # https://martinfowler.com/articles/replaceThrowWithNotification.htm

  def initialize
    @notification_list = Array.new
  end

  def add_notification(message)
    @notification_list << message
  end

  def get_notifications
    # Sorry, but I like explicit returns on accessors :-)
    return @notification_list
  end

  def print_notifications
    # Golfy way of printing contents of an array
    puts @notification_list.join(' ')
  end

  def get_last_notification
    @notification_list.pop
  end

  def any_notifications?
    !@notification_list.empty?
  end

end
