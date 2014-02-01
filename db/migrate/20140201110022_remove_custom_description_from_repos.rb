class RemoveCustomDescriptionFromRepos < ActiveRecord::Migration
  def up
    remove_column :repos, :description
    rename_column :repos, :github_description, :description
  end

  def down
    rename_column :repos, :description, :github_description
    add_column    :repos, :description, :text
  end
end
