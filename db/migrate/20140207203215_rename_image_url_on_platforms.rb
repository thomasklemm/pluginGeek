class RenameImageUrlOnPlatforms < ActiveRecord::Migration
  def change
    rename_column :platforms, :image_url, :icon_path
  end
end
