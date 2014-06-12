class SubmissionsController < ApplicationController

  # Handle submission of repos and links
  # GET /submit?url=https://github.com/rails/rails
  # GET /submit?url=http://blog.com/posts/1&title=Blog%20Post
  def submit
    ensure_presence_of_url

    if url_points_to_github_repo?
      redirect_to new_repo_path(params: repo_params)
    else
      redirect_to new_link_path(params: link_params)
    end
  end

  private

  def ensure_presence_of_url
    url.present? or redirect_to root_url,
      alert: "Please provide a URL on your submission request ('?url=...' is missing)."
  end

  def link_params
    params.slice(:url, :title)
  end

  def repo_params
    { owner_and_name: repo_owner_and_name }
  end

  def repo_owner_and_name
    match_data = github_url_regex.match(url)

    if match_data
      match_data[:owner_and_name]
    else
      false
    end
  end

  def url
    @url ||= params[:url].andand.strip
  end

  def url_points_to_github_repo?
    repo_owner_and_name
  end

  def github_url_regex
    %r{https:\/\/github.com\/(?<owner_and_name>[\w|.]+\/[\w|.]+)}
  end
end
