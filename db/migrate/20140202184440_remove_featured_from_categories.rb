class RemoveFeaturedFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :featured
  end
end
