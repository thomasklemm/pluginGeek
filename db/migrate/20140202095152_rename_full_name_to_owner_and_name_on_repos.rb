class RenameFullNameToOwnerAndNameOnRepos < ActiveRecord::Migration
  def change
    remove_index :repos, [:owner, :name]
    rename_column :repos, :full_name, :owner_and_name
  end
end
