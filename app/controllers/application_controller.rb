class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_authenticated
    flash[:notice] = 'Draw, Knight!'
    redirect_to login_url
  end

  # Authorize Blitz.io Load Testing
  def blitz
    render text: '42'
  end

  ##
  # Helper Methods
  # Markdown Renderer
  include MarkdownHelper
  helper_method :markdown

  # Before Filters
  before_filter :language, :scope
  helper_method :language, :scope

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
end
