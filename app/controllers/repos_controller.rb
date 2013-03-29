class ReposController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :load_repo,          only: [:edit, :update, :destroy]
  after_filter :verify_authorized,   only: [:edit, :update, :destroy]

  # GET /repos/:owner/:name
  def show
    @repo = Repo.where(full_name: full_name).first!.decorate
  end

  # GET /repos/new?owner=thomasklemm&name=Plugingeek
  def new
    @repo = Repo.new(full_name: full_name).decorate
    authorize @repo
  end

  def create
    @repo = Repo.new(full_name: full_name)
    authorize @repo

    if retrieve_from_github(@repo.full_name)
      redirect_to repo_path(@repo), notice: 'Repo has been added.'
    else
      flash.alert = 'Repo could not be found on Github.
        This might be a temporary error only, please try again later.'
      redirect_to root_path
    end
  end

  def edit
    authorize @repo
  end

  def update
    authorize @repo

    if @repo.update_attributes(repo_params)
      redirect_to repo_path(@repo), notice: 'Repo has been updated.'
    else
      render action: :edit
    end
  end

  def destroy
    authorize @repo

    @repo.destroy
    redirect_to root_path, notice: 'Repo has been destroyed.'
  end

  private

  # GET /repos/:owner/:name
  def full_name
    full_name_from_params || owner_and_name_from_params
  end

  def full_name_from_params
    params[:full_name] || (params[:repo] && params[:repo][:full_name])
  end

  def owner_and_name_from_params
    owner = params[:owner] || (params[:repo] && params[:repo][:owner])
    name  = params[:name]  || (params[:repo] && params[:repo][:name])
    "#{ owner }/#{ name }"
  end

  def load_repo
    @repo = Repo.where(full_name: full_name).first!.decorate
  end

  def retrieve_from_github(repo_full_name)
    Rails.env.test? and return repo_full_name == 'rails/rails'
    RepoUpdater.new.perform(repo_full_name)
  end

  def repo_params
    current_user.staff? ? staff_repo_params : user_repo_params
  end

  def staff_repo_params
    params.require(:repo).permit(:full_name, :description, :category_list, :staff_pick, {parent_ids: []})
  end

  def user_repo_params
    params.require(:repo).permit(:description, :category_list, {parent_ids: []})
  end
end
