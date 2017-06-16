class ResoluteParser #
  @tag = "ResoluteParser"

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

    # a really long ass line, usually the one right after the food truck
    food_truck_hours_pattern = "simcal-event-start simcal-event-start-date.*#{date.strftime("%B %-d, %Y")}"

    notifications, food_truck_name, food_truck_schedule = custom_fetch_remote_schedule(endpoint, food_truck_hours_pattern, notifications)

    # <h1><a href="/events/2017/4/18/the-wing-wagon-grill">The Wing Wagon Grill</a></h1>
    # extract between ">.*</a"
    full_sanitizer = Rails::Html::FullSanitizer.new

    # Food truck name:  <div class="simcal-event-details simcal-tooltip-content" style="display: none;"><p><strong><span class="simcal-event-title" itemprop="name">🚚 - Burger Chief</span></strong></p>
    food_truck_name = full_sanitizer.sanitize(food_truck_name)

    # Food truck name:  🚚 - Burger Chief
    begin
      food_truck_name = food_truck_name.split(/-/).last.strip
    rescue Exception => ex
      notifications.add_notification "Couldn't parse food truck name out of return for #{brewery.name}"
      brewery.update_attribute(:food_truck, nil)
      return notifications
    end
    
    unless food_truck_name.blank?
      notifications = FoodTruckUpdater.update_brewery_with_truck(brewery, food_truck_name)
    else
      brewery.update_attribute(:food_truck, nil)
      notifications.add_notification "Could not find a food truck name in #{brewery.name}'s schedule extract."
      Rails.logger.error "#{@tag}::No food truck found in schedule for #{brewery.name}!"
    end

    # Long thing that gets sanitized to:
    #  0    1   2   3   4   5  6  7    8
    # April 3, 2017 @ 4:00 pm  -  8:00 pm
    hours_string = String.new
    food_truck_schedule = full_sanitizer.sanitize(food_truck_schedule)

    split_hours_string = food_truck_schedule.split
    split_hours_string.tap do |s|
      hours_string       = "#{s[4]}#{s[5]}-#{s[7]}#{s[8]}"
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

  private

  def self.custom_fetch_remote_schedule(endpoint, schedulepattern, notifications)
    # No need to call parent method, this requires custom parsing because it's an odd pattern

    # Go get the schedule data from the file

    truck_name        = String.new
    truck_hours       = String.new

    # Read each line of the input file, putting the lines that have truckpattern in
    # the truck_name array and the lines that have the hourspattern in the truck_hours array
    schedule_regex = Regexp.new schedulepattern

    # Resolute has the date on one line, and then an event for that date on the immediately preceeding line.
    # That preceeding line may or may not be a food truck - they use a unicode emoji to indicate a truck
    # \u{1F69A}
    begin
      open(endpoint) { |lines|
        previous_line = String.new
        lines.each do |line|
          if line =~ schedule_regex
            # Get the immediately preceeding line
            event = previous_line

            # Does it have the food truck emoji?
            if event =~ /[\u{1F69A}]/
              truck_name = event
              truck_hours = line
              break
            end
          end

          previous_line = line
        end
      }
    rescue Exception => onoes
      Rails.logger.error "#{@tag}:: #{onoes.message} happened, error getting schedule data"
      notifications.add_notification "Exception when performing GET on #{endpoint}"
      return notifications, nil, nil
    end

    return notifications, truck_name, truck_hours

  end

end
