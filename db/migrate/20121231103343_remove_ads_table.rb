class RemoveAdsTable < ActiveRecord::Migration
  def up
    drop_table :ads
  end
end
