class ReposController < ApplicationController
  def index
    @repos = Repo.all
  end

  def show
    @repo = Repo.find(full_name_from_params)

    # Always redirect to base
    if params[:leftover]
      # Be sure to return to finish request
      return redirect_to @repo
    end

  end


protected

  def full_name_from_params(owner = params[:owner], name = params[:name])
    "#{owner}/#{name}"
  end

end
