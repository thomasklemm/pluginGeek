class TransitionCategoryFields < ActiveRecord::Migration
  def up
    Category.find_each { |c| c[:name_and_languages] = c[:name]; c.save }
    remove_column :categories, :name
  end

  def down
    add_column :categories, :name, :string
    Category.find_each { |c| c[:name] = c[:name_and_languages]; c.save }
  end
end
