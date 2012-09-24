class RenameCategoryColumns < ActiveRecord::Migration
  def change
    add_column :categories, :name_and_languages, :string
    add_column :categories, :languages, :string
  end
end
