class RemoveAdminFlagFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :admin
  end

  def down
    add_column :users, :admin, :boolean, default: false
  end
end
