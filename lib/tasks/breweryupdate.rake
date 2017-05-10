# This should be called nightly to update brewery/food truck pairings
task :update_brewery_with_food_truck
  start_time = Time.now.utc

  today = Date.today
  BreweryScheduleUpdater.update_all_breweries(today)

  end_time = Time.now.utc
  total_min = ((end_time - start_time) / 60).round(0)
  total_sec = ((end_time - start_time) % 60).round(0)
  Rails.logger.debug "Brewery schedule update job completed in #{total_min} minutes and #{total_sec} seconds."
end
