class RenameCategoryColumns < ActiveRecord::Migration
  def change
    add_column :categories, :name_and_languages, :string
  end
end
