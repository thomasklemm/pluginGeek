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
      return redirect_to repo_path(repo_owner_and_name)
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
    @repo ||= Repo.find_by_owner_and_name(repo_owner_and_name)
  end

  def repo_owner_and_name
    @repo_owner_and_name = url.
      gsub('https://github.com/', '').
      gsub(/\?.*$/, ''). # Remove trailing query string
      strip.
      split('/')[0,2]. # Review: Use regex from routes?
      join('/')
  end
end
