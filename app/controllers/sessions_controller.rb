class SessionsController < ApplicationController

  # get '/login'
  def login
  end

  # get '/logout'
  def destroy
    logout
    flash[:notice] = 'Goodbye! Keep making things! :-D'
    redirect_to root_url
  end
end
