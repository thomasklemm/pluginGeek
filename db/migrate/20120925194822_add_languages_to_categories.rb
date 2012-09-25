class AddLanguagesToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :languages, :integer
  end
end
