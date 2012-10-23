class AddDescriptionAndRenameGithubDescriptionOnRepos < ActiveRecord::Migration
  def up
    rename_column :repos, :description, :github_description
    add_column    :repos, :description, :text
  end

  def down
    remove_column :repos, :description
    rename_column :repos, :github_description, :description
  end
end
