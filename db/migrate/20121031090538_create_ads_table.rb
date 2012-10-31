class CreateAdsTable < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :name
      t.string :url
      t.string :description

      t.timestamps
    end
  end
end
