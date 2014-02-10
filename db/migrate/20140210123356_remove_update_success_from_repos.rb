class RemoveUpdateSuccessFromRepos < ActiveRecord::Migration
  def up
    remove_column :repos, :update_success
  end

  def down
    add_column :repos, :update_success, :boolean
  end
end
