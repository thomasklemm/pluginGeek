class DropTableAds < ActiveRecord::Migration
  def up
    drop_table :ads
  end

  def down
    create_table :ads do |t|
      t.string :name
      t.string :description
      t.string :url

      t.timestamps
    end
  end
end
