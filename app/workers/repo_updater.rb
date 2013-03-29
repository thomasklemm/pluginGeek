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

  def perform(full_name)
    repo = Repo.where(full_name: full_name).first_or_initialize
    github_repo = retrieve_repo_from_github(repo)

    repo.assign_fields_from_github(github_repo)
    repo.perform_calculations

    if repo.save
      puts "Repo #{ @repo.full_name } has been updated." and true
    else
      update_failed
      puts "Repo #{ @repo.full_name } could not be updated." and false
    end
  end

  def update_all_repos_in_serial
    repo_names = Repo.pluck(:full_name).shuffle
    repo_names.each { |full_name| perform(full_name) }
    expire_categories
  end

private

  def fetch_repo_from_github(repo)
    json_repo = fetch_repo(repo)
    github_repo = JSON.parse(json_repo)
  end

  def fetch_repo(repo)
    url = "https://api.github.com/repos/#{ repo.full_name }"
    response = HTTPClient.get(url, GITHUB_AUTHENTICATION_HASH)

    response.status != 200 and return repo.update_failed
    response.content
  end

  def expire_categories
    Category.find_each {|category| category.touch}
  end
end
