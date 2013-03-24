class AddRepoNamesToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :repo_names, :text
  end
end
