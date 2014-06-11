# RepoService
#
# This service object knows how to fetch and create or update
# repos from Github.
#
# Usage:
#   repo = Repo.new(owner_and_name: 'rails/rails')
#   RepoService.new(repo).fetch_and_create_or_update
#
RepoService = Struct.new(:repo) do
  def github_repo
    @github_repo ||= fetch_github_repo
  end

  # Returns the repo on successful creation or update
  # or false if Github responded other than 200
  def fetch_and_create_or_update
    assign_fields(github_repo)
    assign_score
    repo.save && repo
  rescue Exceptions::Github::RepoNotFoundError
    false
  end

  private

  def github_authentication_hash
    { client_id: ENV['GITHUB_API_KEY'],
      client_secret: ENV['GITHUB_API_SECRET'] }
  end

  def github_api_repo_url
    "https://api.github.com/repos/#{repo.owner_and_name}"
  end

  def fetch_github_repo
    response = HTTPClient.get(github_api_repo_url, github_authentication_hash)
    raise Exceptions::Github::RepoNotFoundError unless response.status == 200
    JSON.parse(response.content)
  end

  def assign_fields(github_repo)
    repo.owner_and_name    = github_repo['full_name']
    repo.description       = github_repo['description']
    repo.stars             = github_repo['stargazers_count']
    repo.homepage_url      = github_repo['homepage']
    repo.github_updated_at = github_repo['pushed_at']
  end

  def assign_score
    repo.score = (repo.stars + 1) * (repo.staff_pick? ? 1.4 : 1)
  end
end
