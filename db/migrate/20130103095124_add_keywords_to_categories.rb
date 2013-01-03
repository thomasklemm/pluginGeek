class AddKeywordsToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :keywords, :text
  end
end
