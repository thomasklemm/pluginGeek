class ApplicationController < ActionController::Base
  protect_from_forgery

  # Allow CORS for displaying Fonts from Cloudfront in Firefox
  # Source: http://www.tsheffler.com/blog/?p=428
  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  # For all responses in this controller, return the CORS access control headers.

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  def not_authenticated
    redirect_back_or_to login_url, alert: 'Please log in with Github first.'
  end

  # Authorize Blitz.io Load Testing
  def blitz
  	render text: '42'
  end

  ###
  #   Helper Methods
  ###
  include MarkdownHelper

  # Before Filters
  before_filter :language, :scope

  helper_method :logger, :language, :scope,
    :repo_updater, :category_updater, :cache_version, :markdown

  # One cache version for all partials
  # invalidates everything on every deploy
  def cache_version
    'v20'
  end

  # before_filter and helper_method
  def language
    @language ||= assert_language
  end

  def assert_language
    params[:language] = 'ruby' unless params[:language].present?
    params[:language]
  end

  # before_filter and helper_method
  def scope
    @scope ||= assert_scope
  end

  def assert_scope
    params[:scope] = 'categories' if params[:scope].blank?
    params[:scope] = 'repos'      if request.path.start_with?('/repos')
    params[:scope]
  end

  def repo_updater
    @repo_updater ||= RepoUpdater.new
  end

  def category_updater
    @category_updater ||= CategoryUpdater.new
  end

  # Review: Does caching the Rails logger in an instance variable make sense?
  def logger
    @logger ||= Rails.logger
  end

end
