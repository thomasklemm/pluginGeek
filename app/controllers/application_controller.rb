class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_language

  def not_authenticated
    redirect_to login_url, alert: 'Please login first.'
  end

  # Authentication for Blitz.io Load Testing
  def blitz
  	render text: '42'
  end

protected
  
  # Set language and scope
  def set_language
    params[:language] = 'ruby' if params[:language].blank?
    params[:scope] = 'categories' if params[:scope].blank?
    params[:scope] = '' if params[:scope] == 'categories'
    params[:scope] = 'repos' if request.path.start_with?('/repos')
  end

end
