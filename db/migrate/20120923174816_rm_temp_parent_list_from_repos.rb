class RmTempParentListFromRepos < ActiveRecord::Migration
  def up
    remove_column :repos, :temp_parent_list
  end

  def down
    add_column :repos, :temp_parent_list, :string
  end
end
