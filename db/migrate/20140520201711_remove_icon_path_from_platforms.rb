class RemoveIconPathFromPlatforms < ActiveRecord::Migration
  def change
    remove_column :platforms, :icon_path, :text
    remove_column :platforms, :default, :boolean
  end
end
