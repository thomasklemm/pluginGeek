class RemoveGithubUrlFromRepos < ActiveRecord::Migration
  def change
    remove_column :repos, :github_url
  end
end
