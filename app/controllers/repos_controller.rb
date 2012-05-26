class ReposController < ApplicationController
  def index
    @repos = Repo.all
  end

  def show
    @repo = Repo.find_or_initialize_by_full_name(full_name_from_owner_and_name(params[:owner], params[:name]))
   
    if @repo.new_record?
      return redirect_to action: "create", full_name: @repo.full_name
    end

    if params[:leftover]
      return redirect_to repo_path
    end

    if false
      # TODO: This should be nicer?
      redirect_to "/" + @repo.full_name
    end

    if @repo.new_record?
      redirect_to action: "create", full_name: @repo.full_name
    end

  end

  def create
    raise params.inspect
    @repo = Repo.new(full_name: params[:full_name])

    if @repo.first_update_from_github
      flash[:notice] = "Repo successfully added."
      render action: "show"
    else
      flash[:alert] = "Repo could not be added."
      redirect_to root_path
    end
  end

protected

  def full_name_from_owner_and_name(owner, name)
    "#{owner}/#{name}"
  end

end
