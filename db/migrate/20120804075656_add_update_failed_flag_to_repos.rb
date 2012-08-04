class AddUpdateFailedFlagToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :update_success, :boolean, default: false
  end
end
