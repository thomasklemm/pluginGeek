class SubmissionsController < ApplicationController
  GITHUB_BASE = 'https://github.com/'

  # Handle submission of links and repos
  # GET /submit?url=...&title=...
  def submit
    # return redirect to root unless url present
    @url = params[:url].try(:strip)
    @url.present? or return redirect_to_root

    # return redirect to repo if url starts with Github base url
    @url.scan(GITHUB_BASE).present? and return redirect_to_repo

    # TODO: see if thomasklemm.github.com/knight is the submitted link,
    # give user option to add or see repo then or add the link (maybe in flash message)

    # redirect to links controller otherwise
    redirect_to new_link_url(params: params.slice(:url, :title))
  end

protected

  def redirect_to_root
    flash.alert = 'Error: Submission request string malformed, must contain a "url=" parameter.'
    redirect_to root_url
  end

  def redirect_to_repo
    parts = @url.gsub(GITHUB_BASE, '').split('/').compact.map(&:strip)
    full_name = "#{ parts[0] }/#{ parts[1] }"
    redirect_to "/repos/#{ full_name }"
  end
end
