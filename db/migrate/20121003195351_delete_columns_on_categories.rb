class DeleteColumnsOnCategories < ActiveRecord::Migration
  def up
    remove_column :categories, :repo_count
    remove_column :categories, :watcher_count
    remove_column :categories, :popular_repos
    remove_column :categories, :all_repos
    remove_column :categories, :label
  end

  def down
    add_column :categories, :repo_count, :integer
    add_column :categories, :watcher_count, :integer
    add_column :categories, :popular_repos, :string
    add_column :categories, :all_repos, :string
    add_column :categories, :label, :string
  end
end
