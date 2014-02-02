class ReworkOwnerAndNameOnRepos < ActiveRecord::Migration
  def change
    remove_column :repos, :owner
    remove_column :repos, :name
  end
end
