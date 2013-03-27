class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  # Ensure the :language param is set to a valid option
  before_filter :set_language_param

  # Rescue ActiveRecord RecordNotFound errors
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # Rescue Pundit authorization errors
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

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

  def record_not_found
    redirect_to root_url, alert: "Record could not be found."
  end

  def not_authorized
    redirect_to :back, alert: "You're not authorized to perform this action."
  end
end
