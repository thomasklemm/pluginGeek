class RenameDescriptionColumsOnCategories < ActiveRecord::Migration
  def change
    # sunsetting :long_description
    rename_column :categories, :description, :long_description
    rename_column :categories, :short_description, :description
  end
end
