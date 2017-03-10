class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :image_url
      t.references :owner, polymorphic: true

      t.timestamps
    end
  end
end
