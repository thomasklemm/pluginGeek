##
# RepoUpdater
#
# Instance methods:
#   updater = RepoUpdater.new
#   updater.perform('owner/name') => Updates a single repo from Github
#
# Class methods
#   RepoUpdater.update_all_repos_in_serial => self-explanatory
#
class RepoUpdater
  include Sidekiq::Worker
  GITHUB_BASE_URL = 'https://api.github.com'
  GITHUB_AUTHENTICATION_HASH = {
    client_id: ENV['GITHUB_API_KEY'],
    client_secret: ENV['GITHUB_API_SECRET']
  }

  def perform(full_name)
    @repo = Repo.where(full_name: full_name).first_or_initialize

    url = GITHUB_BASE_URL + '/repos/' + full_name
    res = HTTPClient.get(url, GITHUB_AUTHENTICATION_HASH)

    return quit_updating if res.status != 200

    @github = JSON.parse(res.content)

    update_repo_from_github_repo

    perform_calculations_and_modifications

    if @repo.save
      puts "Successfully updated repo #{ @repo.full_name }"
      return true
    else
      puts "Failed saving for repo #{ @repo.full_name }"
      quit_updating
      return false
    end
  end

  def self.update_all_repos_in_serial
    updater = RepoUpdater.new
    Repo.pluck(:full_name).shuffle.each do |full_name|
      updater.perform(full_name)
    end

    # Expire all categories (based on browser testing)
    Category.find_each {|category| category.touch}
  end

private

  def quit_updating
    @repo.update_column(:update_success, false) if @repo.persisted?
    false
  end

  def update_repo_from_github_repo
    @repo.name                = @github['name']
    @repo.owner               = @github['owner']['login']
    @repo.github_description  = @github['description']
    @repo.stars               = @github['watchers']
    @repo.homepage_url        = @github['homepage']
    @repo.github_updated_at   = @github['pushed_at']
  end

  def perform_calculations_and_modifications
    # make urls absolute (e.g. for 'activeadmin.info')
    if @repo.homepage_url.present?
      unless @repo.homepage_url.start_with?('http')
        @repo.homepage_url = "http://#{ @repo.homepage_url }"
      end
    end

    @repo.github_description &&= @repo.github_description.truncate(360)

    @repo.score = score

    @repo.update_success = true
  end

  # A repo's score depends on it's stars counter and github_updated_at timestamp
  def score
    score = (@repo.stars + 1) * activity_multiplier(@repo.github_updated_at)
    score.ceil
  end

  def activity_multiplier(pushed_at)
    difference = Time.zone.now - pushed_at.to_datetime
    multiplier = case difference
      when 0..2.months                    then (2.0 - ( difference /  2.months * 0.4 ))
      when 2.months+1.second..6.months    then (1.6 - ( difference /  6.months * 0.4 ))
      when 6.months+1.second..12.months   then (1.2 - ( difference / 12.months * 0.3 ))
      when 12.months+1.second..18.months  then (0.9 - ( difference / 18.months * 0.2 ))
      when 18.months+1.second..24.months  then (0.7 - ( difference / 24.months * 0.2 ))
      when 24.months+1.second..36.months  then (0.5 - ( difference / 36.months * 0.2 ))
      else  0.3
      end
    multiplier
  end
end
