class AddTempParentListToRepos < ActiveRecord::Migration
  def up
    add_column    :repos, :temp_parent_list, :string
    remove_column :repos, :cached_child_list
    remove_column :repos, :cached_language_list
  end

  def down
    remove_column :repos, :temp_parent_list
    add_column    :repos, :cached_child_list, :string
    add_column    :repos, :cached_language_list, :string
  end
end
