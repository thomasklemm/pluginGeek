class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery

  # Ensure the :language param is set to a valid option
  before_filter :set_language_param

  # Rescue ActiveRecord RecordNotFound errors
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # Rescue Pundit authorization errors
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  def authorize_blitz_io
    render text: '42'
  end

  def authorize_loader_io
    render text: 'loaderio-ca7d285a7cea4be8e79cecd78013aee6'
  end

  # Enable peek in production for staff
  def peek_enabled?
    Rails.env.development? and return true
    Rails.env.test?        and return false
    Rails.env.staging?     and return staff?
    Rails.env.production?  and return staff?
  end

  private

  # Hide a few fields for users that are not staff in the views
  # and decide whether peek bar with application stats is shown
  def staff?
    !!(current_user && current_user.staff?)
  end

  helper_method :staff?

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
