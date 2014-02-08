# This class currently just holds all the stuff extracted from Repo
# that does not feel like it belongs into Repo.
# Find a proper usage and name for it.
#
RepoService = Struct.new(:repo) do
  def github_repo
    @github_repo ||= fetch_github_repo
  end

  def fetch_and_create_or_update
    assign_fields(github_repo)
    assign_score
    repo.save!
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
    res = HTTPClient.get(github_api_repo_url, github_authentication_hash)
    raise 'Repo could not be found on Github' unless res.status == 200
    JSON.parse(res.content)
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
