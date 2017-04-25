class AddIsRestaurantToBrewery < ActiveRecord::Migration[5.0]
  def change
    add_column :breweries, :is_restaurant, :boolean
  end
end
