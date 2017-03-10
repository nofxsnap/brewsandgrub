class CreateBreweries < ActiveRecord::Migration[5.0]
  def change
    create_table :breweries do |t|
      t.string :name
      t.references :contact, foreign_key: true
      t.string :address_street
      t.string :address_city
      t.string :address_state
      t.string :address_zip
      t.string :phone
      t.string :email
      t.string :website
      t.references :menu, foreign_key: true
      t.string :logo
      t.string :yelp_url
      t.text :description

      t.timestamps
    end
  end
end
