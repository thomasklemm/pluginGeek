
class SessionsController < ApplicationController

  # get '/login'
  #   TODO: maybe show screen instead or show screen via ajax
  def redirect_to_oauth
    redirect_to auth_at_provider_path(provider: :github)
  end

  # delete '/sessions'
  def destroy
    logout
    redirect_to root_url, notice: 'Logged out!'
  end
end
