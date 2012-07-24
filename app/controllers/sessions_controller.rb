class SessionsController < ApplicationController

  # get '/login'
  def login
  end

  # get '/logout'
  def destroy
    logout
    flash[:notice] = 'Goodbye! Hope to see you again soon, Knight!'
    redirect_to :back
  end
end
