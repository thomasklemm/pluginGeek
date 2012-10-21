class RemoveChildrenCountFromRepos < ActiveRecord::Migration
  def up
    remove_column :repos, :children_count
  end

  def down
    add_columns :repos, :children_count, :integer, default: 0
  end
end
