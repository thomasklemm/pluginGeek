# This class currently just holds all the stuff extracted from Repo
# that does not feel like it belongs into Repo.
# Find a proper usage and name for it.
#
class GithubRepo


  # Assign updated fields from Git
  def update_repo_from_github(github)
    assign_fields_from_github(github)
    self.update_success = true
    self.save
  end

  # Flag repo as successfully retrieved
  def update_succeeded!
    update_success? or self.update_column(:update_success, true)
    puts "Repo #{ full_name } has been updated successfully."
    true
  end

  # Flag repo as failing to update
  def update_failed!(opts = {})
    if persisted?
      update_success? and self.update_column(:update_success, false)
    else
      update_success? and self.update_success = false
    end

    message = case opts[:reason]
      when :not_found_on_github
        "Repo #{ full_name } could not be found on Github."
      when :not_saved
        "Repo #{ full_name } could not be saved while updating from Github."
      else
        "Repo #{ full_name } could not be updated."
      end

    puts message
    false
  end

  # Update this very record from Github, live and in color
  def retrieve_from_github
    updater = RepoUpdater.new
    updater.update(full_name)
  end


  private

  def assign_fields_from_github(github)
    self.name              = github['name']
    self.owner             = github['owner']['login']
    self.description       = github['description']
    self.stars             = github['watchers']
    self.homepage_url      = github['homepage']
    self.github_updated_at = github['pushed_at']
  end

  def assign_score
    self.score = ((stars + 1) * activity_bonus * staff_pick_bonus).ceil
    self.score = 0 if score < 0
  end

  def activity_bonus
    2.0 - (last_updated / 12.months)
  end

  def staff_pick_bonus
    staff_pick? ? 1.25 : 1
  end
end
