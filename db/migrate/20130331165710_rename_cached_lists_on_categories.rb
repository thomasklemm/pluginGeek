class RenameCachedListsOnCategories < ActiveRecord::Migration
  def change
    rename_column :categories, :language_names, :language_list
    rename_column :categories, :repo_names, :repo_list
  end
end
