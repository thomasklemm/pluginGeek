class ReposController < ApplicationController

  def index
    @repos = Repo.all
  end

  def show
    @repo = Repo.find_by_full_name(full_name_from_params)

    # Always redirect to base
    #   Be sure to return to finish request
    return redirect_to @repo if params[:leftover]

    # Redirect to create action if @repo has not been found
    @repo or return redirect_to action: 'create'
  end

  def create
    @repo = Repo.find_or_initialize_by_full_name(full_name_from_params)

    # Set different flash message if repo is already known
    @repo.new_record? or flash[:notice] = "Repo '#{@repo.full_name}' already known."

    if @repo.initialize_repo_from_github
      # Reload for correct redirection path
      @repo = Repo.find_by_full_name(@repo.full_name)
      flash[:notice] ||= "Repo '#{@repo.full_name}' successfully added."
      redirect_to @repo
    else
      flash[:alert] = "Repo '#{@repo.full_name}' could not be added."
      redirect_to root_path
    end
  end

  # REVIEW: maybe just hide the object or something,
  #   maybe auto-delete / freeze it if not tag has been added in a certain period of time
  def destroy
    @repo = Repo.find_by_full_name(full_name_from_params)

    if @repo.destroy
      flash[:notice] = "Repo '#{ @repo.full_name }' successfully deleted."
      redirect_to :root
    else
      flash[:alert] = "Repo '#{ @repo.full_name }' could not be deleted."
      redirect_to @repo
    end
  end

protected

  def full_name_from_params(owner = params[:owner], name = params[:name])
    "#{owner}/#{name}"
  end

end
