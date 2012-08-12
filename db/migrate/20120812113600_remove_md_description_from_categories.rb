class RemoveMdDescriptionFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :md_description
  end
end
