class AddLanguagesDefaultToCategoriesAndRepos < ActiveRecord::Migration
  def up
    change_column :categories, :languages, :integer, default: 0
    change_column :repos, :languages, :integer, default: 0
  end

  def down
    change_column :categories, :languages, :integer, default: 0
    change_column :repos, :languages, :integer, default: 0
  end
end
