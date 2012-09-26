class AddDefaultsToCategories < ActiveRecord::Migration
  def change
    change_column :categories, :name_and_languages, :string, :null => false
  end
end
