class RemoveLongDescriptionFromCategories < ActiveRecord::Migration
  def up
    remove_column :categories, :long_description
  end

  def down
    add_column :categories, :long_description, :text
  end
end
