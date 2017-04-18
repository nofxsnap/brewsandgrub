class Notification
  # Simple Notification container to implement a basic notification pattern.
  # https://martinfowler.com/articles/replaceThrowWithNotification.htm

  def initialize
    @notification_list = Array.new
  end

  def add_notification(message)
    Rails.logger.info 'Notification::Adding #{message} to notification list.'
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

  def any_notifications?
    if @notification_list.empty?
      Rails.logger.info 'Notification::No notifications in the list.'
      false
    else
      Rails.logger.info 'Notification::The list has notifications.'
      true
    end
  end

end
