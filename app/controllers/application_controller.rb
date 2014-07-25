class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Enables miniprofiler in production for moderators only
  before_action :miniprofiler

  # Redirect user back on detected access violation
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # Redirect user back to previous url after successful login
  before_filter :store_location

  private

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
  def moderator?
    !!current_user.andand.moderator?
  end
  helper_method :moderator?

  def current_platform
    @current_platform ||= Platform.current(platform_id)
  end
  helper_method :current_platform

  def platform_id
    platform_id = params[:platform_id].to_s
    platform_id = platform_id.strip.downcase

    platform_id = 'javascript' if platform_id == 'js'
    platform_id = 'global' if platform_id.blank?

    platform_id
  end

  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    if request.fullpath != "/login" &&
        request.fullpath != "/logout" &&
        request.fullpath != "/users/sign_up" &&
        request.fullpath != "/users/sign_in" &&
        request.fullpath != "/users/sign_out" &&
        request.fullpath != "/users/password" &&
        !request.xhr? && # don't store ajax calls
        request.get? # only store get requests, when performing another request (e.g. post)
                     # a user will be redirected to the page the request originated from
        session[:previous_url_2] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url_2] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url_2] || root_path
  end
end
