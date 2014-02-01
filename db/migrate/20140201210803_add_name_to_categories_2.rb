class AddNameToCategories2 < ActiveRecord::Migration
  def up
    add_column :categories, :name, :text, null: false

    Category.find_each do |category|
      category.update(name: category.name_from_full_name)
    end
  end

  def down
    remove_column :categories, :name
  end
end
