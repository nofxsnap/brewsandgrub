class CreateFoodTrucks < ActiveRecord::Migration[5.0]
  def change
    create_table :food_trucks do |t|
      t.string :name
      t.references :menu, foreign_key: true
      t.references :contact, foreign_key: true
      t.string :email
      t.string :website
      t.string :logo
      t.string :yelp_url
      t.text :description

      t.timestamps
    end
  end
end
