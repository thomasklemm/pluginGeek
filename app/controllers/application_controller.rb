class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_language

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

  # Authorize load testing on blitz.io
  def blitz
    render text: '42'
  end

  private

  def set_language
    # Format language
    params[:language] &&= params[:language].downcase.strip
    # Make 'ruby' default language if none is set
    params[:language] ||= 'ruby'
    # Force 'web' default language if the one that is present is not whitelisted
    params[:language] = 'web' unless Language::All.include?(params[:language])
  end
end
