class AddChildrenToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :children, :string
  end
end
