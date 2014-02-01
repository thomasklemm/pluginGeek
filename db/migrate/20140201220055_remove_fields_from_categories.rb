class RemoveFieldsFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :slug
    remove_column :categories, :language_list
    remove_column :categories, :repo_list
  end
end
