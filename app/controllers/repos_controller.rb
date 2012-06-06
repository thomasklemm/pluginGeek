class ReposController < ApplicationController

  before_filter :require_login, only: [:update, :destroy]

  # GET /repos
  def index
    @repos = Repo.sort_by_knight_score
  end

  # GET /repos/:owner/:name(/*leftover)
  def show
    @repo = Repo.find_by_full_name(full_name_from_params)

    # Always redirect to base
    #   Be sure to return to finish request
    return redirect_to @repo if params[:leftover]

    # Redirect to create action if @repo has not been found
    @repo or return redirect_to action: 'create'
  end

  # GET /repos/:owner/:name/create
  #   (POST /repos/:owner/:name could not be redirected to from 'repos#new')
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

  # PUT /repos/:owner/:name
  def update
    @repo = Repo.find_by_full_name(full_name_from_params)

    if @repo.update_attributes(params[:repo])

      # Update categories based on repo tags
      Updater.update_categories_from_repos

      flash[:notice] = 'Tags successfully saved.'
      redirect_to action: 'show'
    else
      flash[:alert] = 'Tags could not be saved.'
      redirect_to action: 'show'
    end
  end

  # REVIEW: maybe just hide the object or something,
  #   maybe auto-delete / freeze it if not tag has been added in a certain period of time
  def destroy
    @repo = Repo.find_by_full_name(full_name_from_params)

    if @repo.destroy
      # Update categories based on repo tags
      Updater.update_categories_from_repos

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
