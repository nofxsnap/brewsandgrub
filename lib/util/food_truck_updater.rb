class FoodTruckUpdater

  def self.update_brewery_with_truck(brewery, food_truck_name)
      notifications = Notification.new

      # Find the food truck with this name, if it's not there make a new row and flag
      # that it needs to be updated
      food_truck = FoodTruck.find_by_name(food_truck_name)

      if food_truck.blank?
        # Create a new food truck
        Rails.logger.info "#{@tag}:: created a new food truck #{food_truck_name}"
        food_truck = FoodTruck.create(name: food_truck_name)
        food_truck.save!

        notifications.add_notification("New Food Truck!  Name:  #{food_truck_name}  id: #{food_truck.id}")
      end

      Rails.logger.info "#{@tag}:: #{brewery.name} will have #{food_truck_name} today."
      brewery.food_truck = food_truck
      brewery.save!

      notifications
  end

end
