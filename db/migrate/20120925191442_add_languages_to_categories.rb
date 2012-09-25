class AddLanguagesToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :ruby, :boolean
    add_column :categories, :javascript, :boolean
    add_column :categories, :design, :boolean
  end
end
