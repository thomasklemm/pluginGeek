class ChangeColumnsToTextOnRepos < ActiveRecord::Migration
  def up
    change_column :repos, :full_name, :text
    change_column :repos, :owner, :text
    change_column :repos, :name, :text
    change_column :repos, :homepage_url, :text
  end

  def down
    change_column :repos, :full_name, :string
    change_column :repos, :owner, :string
    change_column :repos, :name, :string
    change_column :repos, :homepage_url, :string
  end
end
