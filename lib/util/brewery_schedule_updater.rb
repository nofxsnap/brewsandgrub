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

      # Check to see if the food truck was updated manually

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

    end

    notifications

  end

end
