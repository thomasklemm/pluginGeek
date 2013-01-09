class AddFlagsToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :staff_pick, :boolean, default: false
  end
end
