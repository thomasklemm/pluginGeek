class RenameNameOnCategories < ActiveRecord::Migration
  def change
    rename_column :categories, :full_name, :name
    remove_column :categories, :repos_count
  end
end
