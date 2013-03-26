class SubmissionsController < ApplicationController
  # Handle submission of links and repos
  # GET /submit?url=...&title=...
  def submit
    # Redirect if :url is missing
    url_provided? or return redirect_to_root_path

    # Is a github repo being submitted?
    if github_repo?
      # Is the repo already listed?
      existing_repo? ? (return redirect_to_existing_repo) : (return redirect_to_new_repo)
    end

    # Otherwise create a new link
    redirect_to new_link_url(params: params.slice(:url, :title))
  end

  private

  # Is the :url param present?
  def url_provided?
    @url = params[:url]
    @url.present? && @url.strip
  end

  def redirect_to_root_path
    flash.alert = "Please provide a URL on your submission request ('?url=...' missing)."
    redirect_to root_url
  end

  # Does this URL belong to a Github repo?
  def github_repo?
    @url.scan('https://github.com/').present?
  end

  # Extract the repo's full_name from the provided URL
  def repo_elements
    elements = @url.gsub('https://github.com/', '').split('/').compact.map(&:strip)
  end

  def repo_owner
    repo_elements[0]
  end

  def repo_name
    repo_elements[1]
  end

  def repo_full_name
    "#{ repo_owner }/#{ repo_name }"
  end

  # Is the repo already listed?
  def existing_repo?
    @repo = Repo.where(full_name: repo_full_name).first
    @repo.present?
  end

  def redirect_to_existing_repo
    redirect_to @repo
  end

  def redirect_to_new_repo
    redirect_to new_repo_path(owner: repo_owner, name: repo_name)
  end
end
