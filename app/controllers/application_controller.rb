class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Enable miniprofiler for staff members in production
  before_action :miniprofiler

  # Authorize load testing tools
  def authorize_blitz_io
    render text: '42'
  end

  def authorize_loader_io
    render text: 'loaderio-ca7d285a7cea4be8e79cecd78013aee6'
  end

  # Redirect user back on detected access violation
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  # Handle user access violations
  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to request.headers["Referer"] || root_url
  end

  def record_not_found
    redirect_to root_url, alert: "Record could not be found."
  end

  # Enables miniprofiler for staff members in production
  def miniprofiler
    Rack::MiniProfiler.authorize_request if staff_member?
  end

  # Before action in subcontrollers
  def ensure_staff_member!
    raise Pundit::NotAuthorizedError unless staff_member?
  end

  # For customizing forms for users and staff members among others
  helper_method :staff_member?
  def staff_member?
    !!(current_user && current_user.staff_member?)
  end
end
