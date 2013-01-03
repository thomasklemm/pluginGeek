class SubmissionsController < ApplicationController
  GITHUB_BASE = 'https://github.com/'

  # Handle submission of links and repos
  def submit
    # return redirect to root unless url present
    @url = params[:url].try(:strip)
    @url.present? or return redirect_to_root

    # return redirect to repo if url starts with Github base url
    @url.scan(GITHUB_BASE).present? and return redirect_to_repo

    raise @url.inspect
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
