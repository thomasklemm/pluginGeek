class ReposController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :update, :destroy]
  before_filter :load_repo,          only: [:edit, :update, :destroy]
  after_filter :verify_authorized,   only: [:edit, :update, :destroy]

  # GET /repos/:owner/:name(/*remains)
  def show
    @repo = Repo.where(full_name: full_name).first

    # Retrieve the repo from Github
    @repo.present? or return redirect_to_new_repo

    # Strip additional url remains
    params[:remains] and return redirect_to @repo
  end

  def new
    @repo = Repo.new(full_name: full_name)
  end

  def create
    @repo = Repo.new(full_name: full_name)

    if retrieve_from_github(@repo.full_name)
      redirect_to @repo, notice: "Repo has been added."
    else
      redirect_to root_path, alert: "Repo could not be added. Please email me if this error persists."
    end
  end

  def edit
    authorize @repo
  end

  def update
    authorize @repo

    if @repo.update_attributes(repo_params)
      redirect_to @repo, notice: 'Repo has been updated.'
    else
      render action: :edit
    end
  end

  def destroy
    authorize @repo

    @repo.destroy
    redirect_to root_path, notice: 'Repo has been destroyed.'
  end

protected

  # GET /repos/:owner/:name
  def full_name
    owner = params.fetch(:owner)
    name = params.fetch(:name)

    "#{ owner }/#{ name }"
  end

  def load_or_initialize_repo

  end

  def redirect_to_new_repo
    redirect_to new_repo_path(owner: full_name.split('/')[0], name: full_name.split('/')[1])
  end

  def retrieve_from_github(repo_full_name)
    RepoUpdater.new.perform(repo_full_name)
  end

  def repo_params
    current_user.admin? ? admin_repo_params : user_repo_params
  end

  def admin_repo_params
    params.require(:repo).permit(:full_name, :description, :category_list, parent_ids: [], :staff_pick)
  end

  def user_repo_params
    params.require(:repo).permit(:description, :category_list, parent_ids: [])
  end
end
