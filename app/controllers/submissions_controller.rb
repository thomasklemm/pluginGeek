class SubmissionsController < ApplicationController
  # Handle submission of links and repos
  # GET /submit?url=https://www.github.com/...&title=Github%20Repo
  def submit
    url.present? or return redirect_to root_url,
      alert: "Please provide a URL on your submission request ('?url=...' is missing)."

    # A link is being submitted
    unless is_github_repo?
      return redirect_to new_link_url(params: params.slice(:url, :title))
    end

    # A repo is being submitted
    if repo.present?
      return redirect_to repo
    else
      return redirect_to new_repo_path(owner: repo_owner, name: repo_name)
    end
  end

  private

  def url
    @url ||= params[:url].try(:strip)
  end

  def is_github_repo?
    url.index('https://github.com/').present?
  end

  def repo
    @repo ||= Repo.find_by(full_name: repo_full_name)
  end

  def repo_parts
    @parts ||= url.gsub('https://github.com/', '').
      gsub(/\?.*$/, ''). # Remove trailing query string
      strip.split('/')[0,2]
  end

  def repo_full_name
    repo_parts.join('/')
  end

  def repo_owner
    repo_parts[0]
  end

  def repo_name
    repo_parts[1]
  end
end
