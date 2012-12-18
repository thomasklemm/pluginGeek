class RemoveLanguagesFromCategories < ActiveRecord::Migration
  def up
    remove_column :categories, :languages
  end

  def down
    add_column :categories, :languages, :integer, default: 0
  end
end
