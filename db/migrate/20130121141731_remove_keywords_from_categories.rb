class RemoveKeywordsFromCategories < ActiveRecord::Migration
  def up
    remove_column :categories, :keywords
  end

  def down
    add_column :categories, :keywords, :text
  end
end
