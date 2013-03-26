class SubmissionsController < ApplicationController
  GITHUB_BASE_URL = 'https://github.com/'

  # Handle submission of links and repos
  # GET /submit?url=...&title=...
  def submit
    # Redirect if :url is missing
    url_provided? or return redirect_to_root_path

    # If a repo is submitted, redirect there
    github_repo? and return redirect_to_repo_path

    # Otherwise create a new link
    redirect_to new_link_url(params: params.slice(:url, :title))
  end

protected

  # Is the :url param present?
  def url_provided?
    @url = params[:url]
    @url.present? && @url.strip
  end

  # Does this URL belong to a Github repo?
  def github_repo?
    @url.scan(GITHUB_BASE_URL).present?
  end

  def redirect_to_root_path
    flash.alert = "Please provide a URL on your submission request ('?url=...' missing)."
    redirect_to root_url
  end

  def redirect_to_repo_path
    parts = @url.gsub(GITHUB_BASE_URL, '').split('/').compact.map(&:strip)
    full_name = "#{ parts[0] }/#{ parts[1] }"

    @repo = Repo.where(full_name: full_name).first_or_initialize
    redirect_to @repo
  end
end
