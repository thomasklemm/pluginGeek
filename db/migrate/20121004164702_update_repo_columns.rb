class UpdateRepoColumns < ActiveRecord::Migration
  def up
    rename_column :repos, :watchers, :stars
    remove_column :repos, :forks
    remove_column :repos, :cached_category_list
    remove_column :repos, :label
  end

  def down
    rename_column :repos, :stars, :watchers
    add_column :repos, :forks, :integer, default: 0
    add_column :repos, :cached_category_list, :string
    add_column :repos, :label, :string
  end
end
