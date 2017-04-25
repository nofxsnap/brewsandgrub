require 'open-uri'

class GenericParser

  @tag = "GenericParser"

  def self.fetch_remote_schedule(endpoint, truckpattern, hourspattern, notifications)
    # Go get the schedule data from the file

    truck_name        = Array.new
    truck_hours       = Array.new

    # Read each line of the input file, putting the lines that have truckpattern in
    # the truck_name array and the lines that have the hourspattern in the truck_hours array

    truck_regex = Regexp.new truckpattern

    unless hourspattern.blank?
      schedule_regex = Regexp.new hourspattern
    end

    begin
      open(endpoint) { |lines|
        lines.each_line{ |line|
          if line=~ truck_regex            
            truck_name << line
          elsif !hourspattern.blank? && line =~ schedule_regex
            truck_hours << line
          end
        }
      }
    rescue Exception => onoes
      Rails.logger.error "#{@tag}:: #{onoes.message} happened, error getting schedule data"
      notifications.add_notification "Exception when performing GET on #{endpoint}"
      return notifications, nil, nil
    end

    return notifications, truck_name, truck_hours
  end

end
