class BreweryScheduleUpdater
  @tag = 'BreweryScheduleUpdater'

  def self.update_all_breweries(today)
    Rails.logger.info "#{@tag}::Starting job to update all breweries with today\'s food truck offerings."
    # Collect any notifications about errors with data into a single container
    notifications = Notification.new

    # Get all breweries
    breweries = Brewery.all

    breweries.each do |brewery|
      if (Rails.env.development?)
        Rails.logger.info "#{@tag}:: #{brewery.id}\t#{brewery.name}\t#{brewery.remote_schedule_endpoint}" +
                          "\t#{brewery.remote_endpoint_requires_date}"
      end

      if brewery.is_restaurant
        Rails.logger.info "#{@tag}:: skipping this brewery as it is a restaurant."
        next
      end

      # Start a stopwatch to time each update so we can track latency in each
      # call to scrape the schedule
      start_time = Time.now.utc

      # TODO: Check to see if the food truck was updated manually

      # Send it to the thing based on the brewery name (custom things for each is lame)
      case brewery.name.downcase

      when 'Living the Dream'.downcase
        notifications.add_notifications LivingTheDreamParser.get_food_truck_for_date(brewery, today)
      when 'Grist Brewing Company'.downcase
        notifications.add_notifications GristParser.get_food_truck_for_date(brewery, today)
      when 'Thirty Eight State Brewing Company'.downcase
        notifications.add_notifications ThirtyEightStateParser.get_food_truck_for_date(brewery, today)
      when 'Lone Tree Brewing Company'.downcase
        notifications.add_notifications LoneTreeParser.get_food_truck_for_date(brewery, today)
      when 'Resolute Brewing Company'.downcase
        notifications.add_notifications ResoluteParser.get_food_truck_for_date(brewery, today)
      else
        error = "No parser found for #{brewery.name}."
        Rails.logger.error error
        notifications.add_notification error
      end

      end_time = Time.now.utc

      elapsed_time_in_ms = (end_time-start_time) * 1000
      Rails.logger.info "#{@tag}:: (PERF) #{brewery.name} update in #{elapsed_time_in_ms}ms"
      if (elapsed_time_in_ms > 5000)
        Rails.logger.info "#{@tag}:: (PERF) WARNING: #{brewery.name} took a ridiculously long time to update."
      end
    end

    Rails.logger.info "#{@tag}:: job complete."

    # At this point the job is done, we should have all potential brewery=>food_truck
    # relationships set up.
    notifications.print_notifications(@tag)
  end

end
