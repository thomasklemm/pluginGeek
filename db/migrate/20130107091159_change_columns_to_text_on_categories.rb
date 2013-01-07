class ChangeColumnsToTextOnCategories < ActiveRecord::Migration
  def up
    change_column :categories, :full_name, :text
    change_column :categories, :slug, :text
  end

  def down
    change_column :categories, :full_name, :string
    change_column :categories, :slug, :string
  end
end
