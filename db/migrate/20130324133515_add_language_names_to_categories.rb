class AddLanguageNamesToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :language_names, :text
  end
end
