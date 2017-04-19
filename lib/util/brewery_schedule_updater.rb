class BreweryScheduleUpdater
  @tag = 'BreweryScheduleUpdater'

  def self.update_all_breweries
    Rails.logger.info '#{@tag}::Starting job to update all breweries with today\'s food truck offerings.'

    # Collect any notifications about errors with data into a single container
    notifications = Notification.new

    # Get all breweries
    breweries = Brewery.all

    breweries.each do |brewery|
      if (Rails.env.development? or Rails.env.test?)
        Rails.logger.info '#{@tag}:: #{brewery.id}\t#{brewery.name}\t#{brewery.remote_schedule_endpoint}' +
                          '\t#{brewery.remote_endpoint_requires_date}'
      end

      # Check to see if the food truck was updated manually

      # Send it to the thing based on the brewery name (custom things for each is lame)

      if brewery.name eq 'Living the Dream'
        notifications = LivingTheDreamParser.get_todays_food_truck(brewery, notfications)
      end



    end

  end

end
