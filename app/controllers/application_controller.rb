class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Enables miniprofiler in production for moderators only
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

  def miniprofiler
    Rack::MiniProfiler.authorize_request if moderator?
  end

  # To be used as a before action in some controllers
  def ensure_moderator!
    raise Pundit::NotAuthorizedError unless moderator?
  end

  # Used to show or hide links and customize forms
  helper_method :moderator?
  def moderator?
    !!(current_user && current_user.moderator?)
  end
end
