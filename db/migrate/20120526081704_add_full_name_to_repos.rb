class AddFullNameToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :full_name, :string
    add_index :repos, :full_name
  end
end
