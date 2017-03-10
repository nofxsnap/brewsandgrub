class CreateMenuItems < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.string :description
      t.string :image
      t.money :price

      t.timestamps
    end
  end
end