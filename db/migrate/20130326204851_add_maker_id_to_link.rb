class AddMakerIdToLink < ActiveRecord::Migration
  def change
    add_column :links, :maker_id, :integer
  end
end
