class ApplicationController < ActionController::Base
  protect_from_forgery

  # Before Filters
  before_filter :set_language_and_scope

  def not_authenticated
    redirect_to login_url, alert: 'Please sign up or log in with Github first.'
  end

  # Authentication for Blitz.io Load Testing
  def blitz
  	render text: '42'
  end

  def logger
    @logger ||= Rails.logger
  end

  def repo_updater
    @repo_updater ||= RepoUpdater.new
  end

  def category_updater
    @category_updater ||= CategoryUpdater.new
  end

protected
  
  # Set language and scope
  def set_language_and_scope
    params[:language] = 'ruby'    if params[:language].blank?
    params[:scope] = 'categories' if params[:scope].blank?
    params[:scope] = ''           if params[:scope] == 'categories'
    params[:scope] = 'repos'      if request.path.start_with?('/repos')
  end

end
