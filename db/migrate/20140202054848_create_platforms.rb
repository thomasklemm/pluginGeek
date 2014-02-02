class CreatePlatforms < ActiveRecord::Migration
  def change
    create_table :platforms do |t|
      t.text :name, null: false
      t.text :slug, null: false
      t.integer :position, null: false
      t.text :image_url
      t.boolean :default, default: false

      t.timestamps
    end
  end
end
