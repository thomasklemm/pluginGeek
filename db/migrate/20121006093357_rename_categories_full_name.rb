class RenameCategoriesFullName < ActiveRecord::Migration
  def change
    rename_column :categories, :name_and_languages, :full_name
  end
end
