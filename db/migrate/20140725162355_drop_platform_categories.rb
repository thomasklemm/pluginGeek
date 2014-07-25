class DropPlatformCategories < ActiveRecord::Migration
  def change
    drop_table :platform_categories
  end
end
