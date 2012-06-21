
class SessionsController < ApplicationController

  # get '/login'
  def login
  end

  # def redirect_to_oauth
  #  redirect_to auth_at_provider_path(provider: :github)
  # end

  # get '/logout'
  def destroy
    logout
    redirect_to root_url, notice: 'Logged out!'
  end
end
