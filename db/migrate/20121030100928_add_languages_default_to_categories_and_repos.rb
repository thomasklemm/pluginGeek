class AddLanguagesDefaultToCategoriesAndRepos < ActiveRecord::Migration
  def change
    change_column :categories, :languages, :integer, default: 0
    change_column :repos, :languages, :integer, default: 0
  end
end
