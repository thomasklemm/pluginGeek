class ApplicationController < ActionController::Base
  protect_from_forgery

  # Allow CORS for displaying Fonts from Cloudfront in Firefox
  after_filter :set_cors
  def set_cors
    headers['Access-Control-Allow-Origin']  = '*'
    headers['Access-Control-Allow-Methods'] = '*'
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
