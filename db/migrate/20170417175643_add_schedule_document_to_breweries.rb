class AddScheduleDocumentToBreweries < ActiveRecord::Migration[5.0]
  def change
    add_column :breweries, :schedule_document, :text
    add_column :breweries, :remote_schedule_endpoint, :string
  end
end
