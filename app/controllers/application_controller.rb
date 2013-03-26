class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  # Ensure the :language param is set to a valid option
  before_filter :set_language_param

  # Remove unknown subdomains
  def remove_subdomain
    redirect_to root_url(subdomain: false)
  end

  # Redirect subdomains to namespaced path using 301 redirect
  def redirect_subdomain
    subdomain = request.subdomain.downcase.strip
    redirect_to root_url(subdomain: false) + subdomain, status: :moved_permanently
  end

  # Authorize load testing with Blitz.io
  def blitz
    render text: '42'
  end

  private

  def set_language_param
    # Format language
    params[:language] &&= params[:language].downcase.strip
    # Make 'ruby' default language if none is set
    params[:language] ||= 'ruby'
    # Force 'web' default language if the one that is present is not whitelisted
    params[:language] = 'web' unless Language::All.include?(params[:language])
  end
end
