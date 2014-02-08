# RepoUpdater
# makes fetching and creating or updating repos from Github
# easy as cake
#
# Use:
# - RepoUpdater.update('owner/name') => Single repo
# - RepoUpdater.update_all => All repos
#
class RepoUpdater
  def self.update(owner_and_name)
    # Yes, this is new syntax, custom case-insensitive search
    repo = Repo.find_by_owner_and_name!(owner_and_name)
    RepoService.new(repo).fetch_and_create_or_update
  end

  def self.update_all
    Repo.find_in_batches(batch_size: 100) do |repo|
      RepoService.new(repo).fetch_and_create_or_update
    end
  end
end
