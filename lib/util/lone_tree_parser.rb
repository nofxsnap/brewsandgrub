class LoneTreeParser < GenericParser
  @tag = "LoneTreeParser"

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
    food_truck_pattern = "(\\s+)Food\\sTruck:"

    # <span class="tribe-event-date-start">April 26 @ 4:00 pm</span> - <span class="tribe-event-time">8:00 pm</span>	</div>
    food_truck_hours_pattern = "tribe-event-date-start\">#{date.strftime("%B %d")}"

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

    # Food Truck: Denver 808/Ohana Denver	</a>
    # strip extra leading whitespace, chomp off the </a>
    food_truck_name = food_truck_name.scan(/(?<=:)(.*)(?=<\/a)/).last.first.strip

    unless food_truck_name.blank?
      notifications = FoodTruckUpdater.update_brewery_with_truck(brewery, food_truck_name)
    else
      brewery.update_attribute(:food_truck, nil)
      notifications.add_notification "Could not find a food truck name in #{brewery.name}'s schedule extract."
      Rails.logger.error "#{@tag}::No food truck found in schedule for #{brewery.name}!"
    end

    #   0      1                                  2 3 4    5         6 7      8                            9  10      11
    # <span class="tribe-event-date-start">April 26 @ 4:00 pm</span> - <span class="tribe-event-time">8:00 pm</span>	</div>
    hours_string = String.new
    full_sanitizer = Rails::Html::FullSanitizer.new

    # Remove the HTML tags
    food_truck_schedule = full_sanitizer.sanitize(food_truck_schedule)

    #    0    1 2  3    4 5  6   7
    # "April 26 @ 4:00 pm - 8:00 pm"
    split_hours_string = food_truck_schedule.split
    split_hours_string.tap do |s|
      hours_string       = "#{s[3]}#{s[4]}-#{s[6]}#{s[7]}"
    end

    unless hours_string.blank?
      brewery.update_attribute(:event_hours, hours_string)
    else
      brewery.update_attribute(:event_hours, nil)
      notifications.add_notification "Could not find hours in #{food_truck_schedule} extract."
      Rails.logger.error "#{@tag}:: No food truck hours found for #{brewery.name}"
    end

    notifications
  end

end
