class AddReposCounterCacheToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :repos_count, :integer, default: 0
    add_index :categories, :repos_count

    Category.find_each do |category|
      Category.reset_counters(category.id, :repos)
    end
  end
end
