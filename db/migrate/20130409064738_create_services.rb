class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.text :name
      t.text :display_url
      t.text :target_url
      t.text :description

      t.timestamps
    end
  end
end
