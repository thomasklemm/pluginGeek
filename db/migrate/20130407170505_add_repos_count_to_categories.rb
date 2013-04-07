class AddReposCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :repos_count, :integer, default: 0
  end
end
