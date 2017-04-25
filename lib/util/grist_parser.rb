class GristParser < GenericParser

  @tag = "GristParser"

  def self.fetch_remote_schedule(endpoint, truckpattern, schedulepattern, notifications)
    super
  end

  def self.get_food_truck_for_date(brewery, date)
    notifications = Notification.new

    Rails.logger.info '#{@tag}::starting get_todays_food_truck'

    endpoint = brewery.remote_schedule_endpoint
    Rails.logger.info '#{@tag}:: endpoint for #{brewery.name} is #{endpoint}'

    if brewery.remote_endpoint_requires_date
      endpoint = DatePatternGenerator.generate_date_string_for_brewery(brewery, date)
    end

    if endpoint.blank?
      error = "#{@tag}:: Could not determine correct endpoint to retrieve schedule document from #{brewery.name}"
      Rails.logger.error error
      notifications.add_notification error
    end

    # TODO: store the parse keywords in the model?
    # events/trucks are bounded in <h2>
    # schedule is bounded in <strong>
    notifications, todays_schedule, todays_scheduled_hours = fetch_remote_schedule(endpoint, "<h2>", "<strong>", notifications)

    if todays_schedule.blank?
      error = "#{@tag}:: did not get truck name data back from #{endpoint} for #{brewery.name}"
      notifications.add_notification error
      Rails.logger.error error
      return notifications
    end

    if todays_scheduled_hours.blank?
      error = "#{@tag}:: did not get truck schedule data back from #{endpoint} for #{brewery.name}"
      notifications.add_notification error

      # TODO:  This isn't fatal
    end

    food_truck_name     = String.new
    food_truck_schedule = String.new

    if todays_schedule.size > 1
      # TODO:  need something better than 'generally the event is listed first'
      # TODO:  Grist is wildly inconsistent, here's a best guess

      # Skip if it says 'industry', skip if it says 'beer', skip if it says 'trivia'
      todays_schedule.each_with_index do |event,index|
        e = event.downcase

        # TODO: move these hotwords into the model?
        unless ( e.include?('beer') || e.include?('industry') || e.include?('trivia') )
          food_truck_name     = event
          food_truck_schedule = todays_scheduled_hours[index]
          break
        end
      end
    else
      food_truck_name = todays_schedule.first
      food_truck_schedule = todays_scheduled_hours.first
    end

    food_truck_name = food_truck_name.scan(/(?<=\<h2\>)(.*)(?=<\/h2\>)/).last.first

    unless food_truck_name.blank?
      notifications = FoodTruckUpdater.update_brewery_with_truck(brewery, food_truck_name)
    else
      brewery.update_attribute(:food_truck, nil)
      notifications.add_notification "Could not find a food truck name in #{food_truck_name} extract."
      Rails.logger.error "#{@tag}::No food truck found in schedule for #{brewery.name}!"
    end

    #   0                         1  2  3  4    5
    # <strong>4/6/2017</strong> 4:00 PM - 9:00 PM<br>
    hours_string = String.new
    split_hours_string = food_truck_schedule.split
    split_hours_string.tap do |s|
      hours_string       = "#{s[1]}#{s[2].downcase}-#{s[4]}#{s[5].chomp('<br>').downcase}"
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
