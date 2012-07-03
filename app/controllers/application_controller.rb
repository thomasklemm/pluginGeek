class ApplicationController < ActionController::Base
  protect_from_forgery

  def not_authenticated
    redirect_to login_url, alert: 'Please login first.'
  end

  # Authentication for Blitz.io Load Testing
  def blitz
  	render text: '42'
  end
end
