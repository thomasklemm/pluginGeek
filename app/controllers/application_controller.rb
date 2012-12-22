class ApplicationController < ActionController::Base
  protect_from_forgery

  # Helper methods
  include MarkdownHelper
  helper_method :markdown

  # Redirect subdomains to namespaced path using 301 redirect
  def redirect_subdomain
    subdomain = request.subdomain.downcase.strip
    redirect_to root_url(subdomain: false) + subdomain, status: :moved_permanently
  end

  # Remove unknown subdomains
  def remove_subdomain
    redirect_to root_url(subdomain: false)
  end

  # authorize load testing on blitz.io
  def blitz
    render text: '42'
  end

  # for oauth
  def not_authenticated
    flash[:notice] = 'Draw, Knight!'
    redirect_to login_url
  end

  # Filters
  before_filter :set_language_or_default
  def set_language_or_default
    # format language
    params[:language] &&= params[:language].downcase.strip
    # make 'web' default language if none is set
    params[:language] ||= 'ruby' # Set to web later
    # force 'web' default language if the one that is present is not whitelisted
    params[:language] = 'web' unless Language::All.include?(params[:language])
  end
end
