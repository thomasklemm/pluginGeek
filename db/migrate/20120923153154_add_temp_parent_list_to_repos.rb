class AddTempParentListToRepos < ActiveRecord::Migration
  def change
    add_column    :repos, :temp_parent_list, :string
    remove_column :repos, :cached_child_list
    remove_column :repos, :cached_language_list
  end
end
