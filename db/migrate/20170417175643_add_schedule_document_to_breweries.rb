class AddScheduleDocumentToBreweries < ActiveRecord::Migration[5.0]
  def change
    # Store the URL where the brewery's schedule can be found on the web
    add_column :breweries, :remote_schedule_endpoint, :string

    # Is the URL RESTful, does it require a date?
    add_column :breweries, :remote_endpoint_requires_date, :boolean
  end
end
