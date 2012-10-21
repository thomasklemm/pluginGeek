class RemoveReposCountFromCategories < ActiveRecord::Migration
  def up
    remove_column :categories, :repos_count
  end

  def down
    add_column :categories, :repos_count, :integer, default: 0
  end
end
