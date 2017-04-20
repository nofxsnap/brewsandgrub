class AddPatternsToBreweries < ActiveRecord::Migration[5.0]
  def change
    add_column :breweries, :schedule_scan_pattern, :string
    add_column :breweries, :schedule_gsub_pattern, :string
  end
end
