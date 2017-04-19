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
          # TODO:  figure out how to store the pattern we're looking for
          if line =~ /#{food_truck_pattern}/
            todays_schedule << line
          end
        }
      }
    rescue Exception => derp
      Rails.logger.fatal '#{tag}:: #{derp} happened, error getting schedule data'
      notifications.add_notification('Exception when performing GET on #{endpoint}')
    end

    # Sometimes the schedule has an event AND a food truck.
    if todays_schedule.size > 1
      # TODO:  need something better than 'generally the event is listed first'
      food_truck_name = todays_schedule.last
    else
      notifications.add_notification('When parsing the schedule document, we found no matches for today.')
    end

    # Find the food truck with this name, if it's not there make a new row and flag
    # that it needs to be updated
    # <h1><a href="/events/2017/4/18/the-wing-wagon-grill">The Wing Wagon Grill</a></h1>
    # extract between ">.*</a"
    food_truck_name = food_truck_name.scan(/(?<=\">)(.*)(?=<\/a)/).last.first
    food_truck = FoodTruck.find_by_name(food_truck_name)

    unless food_truck.blank?
      Rails.logger.info "#{@tag}:: #{brewery.name} will have #{food_truck_name} today."
      brewery.food_truck = food_truck
      brewery.save!
    else
      # Create a new food truck
      Rails.logger.info "#{@tag}:: created a new food truck #{food_truck_name}"
      new_food_truck = FoodTruck.create(name: food_truck_name)
      new_food_truck.save!

      notifications.add_notification("New Food Truck!  Name:  #{food_truck_name}  id: #{new_food_truck.id}")
    end

    notifications
  end
end
