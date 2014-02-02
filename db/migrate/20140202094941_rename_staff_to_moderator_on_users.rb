class RenameStaffToModeratorOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :staff, :moderator
  end
end
