class ReposController < ApplicationController
  def index
    @repos = Repo.all
  end

  def show
    @repo = Repo.find_by_full_name(full_name_from_owner_and_name(params[:owner], params[:name]))
  end
end
