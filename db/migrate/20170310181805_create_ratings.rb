class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.references :owner, polymorphic: true
      t.integer :rating

      t.timestamps
    end
  end
end
