class AddCategoriesCountToPlatforms < ActiveRecord::Migration

  def change
    add_column :platforms, :categories_count, :integer, default: 0
    add_index :platforms, :categories_count

    # Initialize counter cache
    Platform.find_each do |platform|
      platform.update(categories_count: platform.categories.count)
    end
  end

end
