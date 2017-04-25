class LivingTheDreamParser < GenericParser
  @tag = "LivingTheDreamParser"

  def self.fetch_remote_schedule(endpoint, truckpattern, schedulepattern, notifications)
    super
  end

  def self.get_food_truck_for_date(brewery, date)
    notifications = Notification.new

    Rails.logger.info '#{@tag}:: starting get_todays_food_truck'

    # Get the schedule from the given endpoint
    Rails.logger.info '#{@tag}:: endpoint for this brewery = #{endpoint}'

    if brewery.remote_endpoint_requires_date
      endpoint = DatePatternGenerator.generate_date_string_for_brewery(brewery, date)
    end

    if endpoint.blank?
      error = "#{@tag}:: Could not determine correct endpoint to retrieve schedule document from #{brewery.name}"
      Rails.logger.error error
      notifications.add_notification error

      return notifications  # Exit this method, we can't get the schedule data.
    end

    # Go get the thing
    # The pattern we're looking for is today:
    food_truck_pattern = "<h1><a href=\"/events/#{date.strftime("%Y/%-m/%-d/")}"

    # Tuesday, April 18, 2017,  4:00pm &ndash;  8:00pm
    food_truck_hours_pattern = "#{date.strftime("%A, %B %-d, %Y,")}"

    todays_schedule        = Array.new
    todays_scheduled_hours = Array.new

    notifications, todays_schedule, todays_scheduled_hours = fetch_remote_schedule(endpoint, food_truck_pattern, food_truck_hours_pattern, notifications)

    # Sometimes the schedule has an event AND a food truck.
    if todays_schedule.size > 1
      # TODO:  need something better than 'generally the event is listed first'
      food_truck_name = todays_schedule.last
      food_truck_schedule = todays_scheduled_hours.last
    else
      food_truck_name = todays_schedule.first
      food_truck_schedule = todays_scheduled_hours.first
    end

    # <h1><a href="/events/2017/4/18/the-wing-wagon-grill">The Wing Wagon Grill</a></h1>
    # extract between ">.*</a"
    food_truck_name = food_truck_name.scan(/(?<=\">)(.*)(?=<\/a)/).last.first

    # Returns updated notifications
    notifications = FoodTruckUpdater.update_brewery_with_truck(brewery, food_truck_name)

    # Get hours
    split_hours_string = food_truck_schedule.split
    hours_string       = "#{split_hours_string[4]}-#{split_hours_string[6]}"
    brewery.update_attribute(:event_hours, hours_string)

    notifications
  end

end
