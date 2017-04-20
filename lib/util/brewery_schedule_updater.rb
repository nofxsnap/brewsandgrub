class BreweryScheduleUpdater
  @tag = 'BreweryScheduleUpdater'

  def self.update_all_breweries(today)
    Rails.logger.info '#{@tag}::Starting job to update all breweries with today\'s food truck offerings.'

    # Collect any notifications about errors with data into a single container
    notifications = Notification.new

    # Get all breweries
    breweries = Brewery.all

    breweries.each do |brewery|
      if (Rails.env.development?)
        Rails.logger.info '#{@tag}:: #{brewery.id}\t#{brewery.name}\t#{brewery.remote_schedule_endpoint}' +
                          '\t#{brewery.remote_endpoint_requires_date}'
      end

      # Check to see if the food truck was updated manually

      # Send it to the thing based on the brewery name (custom things for each is lame)

      if brewery.name == 'Living the Dream'
        notifications.add_notifications LivingTheDreamParser.get_food_truck_for_date(brewery, today)        
      end

    end

    notifications

  end

end
