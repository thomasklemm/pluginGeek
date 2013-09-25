class SubmissionsController < ApplicationController
  # Handle submission of links and repos
  # GET /submit?url=https://www.github.com/...&title=Github%20Repo
  def submit
    # Redirect if :url is missing
    url.present? or return redirect_to root_url,
      alert: "Please provide a URL on your submission request ('?url=...' missing)."

    if github_repo?
      if repo.present?
        return redirect_to repo
      else
        return redirect_to new_repo_path(owner: repo_owner, name: repo_name)
      end
    end

    # Otherwise create a new link
    redirect_to new_link_url(params: params.slice(:url, :title))
  end

  private

  def url
    @url ||= params[:url].try(:strip)
  end

  def github_repo?
    url.scan('https://github.com/').present?
  end

  def repo
    @repo ||= Repo.find_by(full_name: full_name)
  end

  def repo_elements
    @repo_elements ||= begin
      # Remove query string
      u = url.gsub('https://github.com/', '').gsub(/\?.*/, '')
      u.split('/').map(&:strip)
    end
  end

  def repo_full_name
    "#{ repo_owner }/#{ repo_name }"
  end

  def repo_owner
    repo_elements[0]
  end

  def repo_name
    repo_elements[1]
  end
end
