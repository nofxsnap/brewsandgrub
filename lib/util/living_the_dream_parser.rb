require 'open-uri'

class LivingTheDreamParser
@tag = "LivingTheDreamParser"

  def self.get_todays_food_truck(brewery, notifications)
    Rails.logger.info '#{@tag}:: starting get_todays_food_truck'

    # Get the schedule from the given endpoint
    endpoint = brewery.remote_schedule_endpoint
    Rails.logger.info '#{@tag}:: endpoint for this brewery = #{endpoint}'

    if brewery.remote_endpoint_requires_date
      # Date url formatting should be between pipes ||<pattern>||
      unformatted_date_substr = endpoint.scan(/\|\|*.+\|\|/).last
      formatted_date_substr = String.new

      # Living the Dream
      if unformatted_date_substr =~ /\|\|MONTH-YYYY\|\|/
        endpoint.gsub!(/\|\|MONTH-YYYY\|\|/, Date.today.strftime("%B") + "-" + Date.today.year.to_s)
      end

      Rails.logger.info '#{tag}:: Determined this is what the endpoint should look like: #{endpoint}'
    end

    # Go get the thing
    # The pattern we're looking for is today:
    food_truck_pattern = "<h1><a href=\"/events/#{Date.today.strftime("%Y/%-m/%-d/")}"
    todays_schedule = Array.new

    begin
      open(endpoint) { |lines|
        lines.each_line{ |line|
          # TODO:  should we store the pattern we're looking for in the brewery table
          if line =~ /#{food_truck_pattern}/
            todays_schedule << line
          end
        }
      }
    rescue Exception => derp
      Rails.logger.error '#{tag}:: #{derp} happened, error getting schedule data'
      notifications.add_notification('Exception when performing GET on #{endpoint}')
    end

    # Sometimes the schedule has an event AND a food truck.
    if todays_schedule.size > 1
      # TODO:  need something better than 'generally the event is listed first'
      food_truck_name = todays_schedule.last
    else
      food_truck_name = todays_schedule.first
    end

    # <h1><a href="/events/2017/4/18/the-wing-wagon-grill">The Wing Wagon Grill</a></h1>
    # extract between ">.*</a"
    food_truck_name = food_truck_name.scan(/(?<=\">)(.*)(?=<\/a)/).last.first
    notifications = FoodTruckUpdater.update_brewery_with_truck(brewery, food_truck_name, notifications)

    notifications
  end
end
