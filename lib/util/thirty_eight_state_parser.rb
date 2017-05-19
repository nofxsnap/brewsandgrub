class ThirtyEightStateParser < GenericParser
  @tag = "ThirtyEightStateParser"

  #http://38statebrew.com/wp-admin/admin-ajax.php?action=spidercalendarbig&theme_id=13&calendar_id=1&ev_ids=165&eventID=165&date=2017-04-25

  # They seriously have the worst PHP website ever.

  def self.fetch_remote_schedule(endpoint, truckpattern, schedulepattern, notifications)
    super
  end

  def self.get_food_truck_for_date(brewery, date)
    notifications = Notification.new

    Rails.logger.info "#{@tag}:: starting get_todays_food_truck"

    # Get the schedule from the given endpoint
    Rails.logger.info "#{@tag}:: endpoint for this brewery = #{brewery.remote_schedule_endpoint}"

    if brewery.remote_endpoint_requires_date
      endpoint = DatePatternGenerator.generate_date_string_for_brewery(brewery, date)
    else
      endpoint = brewery.remote_schedule_endpoint
    end

    if endpoint.blank?
      error = "#{@tag}:: Could not determine correct endpoint to retrieve schedule document from #{brewery.name}"
      Rails.logger.error error
      notifications.add_notification error

      return notifications  # Exit this method, we can't get the schedule data.
    end

    # Go get the thing
    # The pattern we're looking for is today:
    food_truck_pattern = "38statebrew.*spidercalendarbig.*date=#{date.strftime("%Y-%m-%-d")}&"  

    # Tuesday, April 18, 2017,  4:00pm &ndash;  8:00pm
    # food_truck_hours_pattern = "#{date.strftime("%A, %B %-d, %Y,")}"
    # 38 State doesn't have truck hours.  they all start at midnight because of course they do
    todays_schedule        = Array.new

    notifications, todays_schedule, todays_scheduled_hours = fetch_remote_schedule(endpoint, food_truck_pattern, nil, notifications)

    # Sometimes the schedule has an event AND a food truck.
    if todays_schedule.size > 1
      # TODO:  need something better than 'generally the event is listed first'
      food_truck_name = todays_schedule.last
    else
      food_truck_name = todays_schedule.first
    end

    #    <p>&nbsp;Donatella&#039;s Pizza Truck</b>
    #    <p>&nbsp;Saucy Buns BBQ</b>
    unless food_truck_name.blank?
      food_truck_name = food_truck_name.scan(/(?<=&nbsp;)(.*)(?=<\/b)/).last.first
      notifications = FoodTruckUpdater.update_brewery_with_truck(brewery, food_truck_name)
    else
      brewery.update_attribute(:food_truck, nil)
      notifications.add_notification "Could not find a food truck name in #{food_truck_name} extract."
      Rails.logger.error "#{@tag}::No food truck found in schedule for #{brewery.name}!"
    end

    # Get hours
    # split_hours_string = food_truck_schedule.split
    # hours_string       = "#{split_hours_string[4]}-#{split_hours_string[6]}"
    # brewery.update_attribute(:event_hours, hours_string)

    notifications
  end

end
