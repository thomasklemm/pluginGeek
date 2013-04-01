##
# RepoUpdater
#
# Instance methods:
#   updater = RepoUpdater.new
#   updater.perform('owner/name') => Updates a single repo from Github
#   updater.update_all => Updates all repos from Github in serial
#
class RepoUpdater
  include Sidekiq::Worker

  GITHUB_AUTHENTICATION_HASH = {
    client_id: ENV['GITHUB_API_KEY'],
    client_secret: ENV['GITHUB_API_SECRET']
  }

  def update(full_name)
    repo = Repo.where(full_name: full_name).first_or_initialize
    response = fetch_repo_from_github(repo)

    response.status == 200 or return repo.update_failed!(reason: :not_found_on_github)

    json_repo = response.content
    github_repo = JSON.parse(json_repo)

    if repo.update_repo_from_github(github_repo)
      repo.update_succeeded! and true
    else
      repo.update_failed!(reason: :not_saved) and false
    end
  end

  alias_method :perform, :update

  def update_all
    repo_names = Repo.pluck(:full_name).shuffle

    repo_names.each do |full_name|
      update(full_name)
    end

    Category.expire_all
  end

private

  def fetch_repo_from_github(repo)
    url = "https://api.github.com/repos/#{ repo.full_name }"
    response = HTTPClient.get(url, GITHUB_AUTHENTICATION_HASH)
  end
end
