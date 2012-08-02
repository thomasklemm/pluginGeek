class AddCachesToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :cached_category_list, :string
    add_column :repos, :cached_child_list, :string
    add_column :repos, :cached_language_list, :string
  end
end
