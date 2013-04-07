class ReposController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :refresh]
  before_filter :load_repo,          only: [:edit, :update, :destroy, :refresh]
  after_filter :verify_authorized,   only: [:edit, :update, :destroy, :refresh]

  # GET /repos/:owner/:name
  def show
    @repo = Repo.where(full_name: full_name).first!.decorate
    # TODO: Specs
  rescue ActiveRecord::RecordNotFound
    redirect_to new_repo_path(full_name: full_name)
  end

  # GET /repos/new?owner=thomasklemm&name=Plugingeek
  def new
    @repo = Repo.new(full_name: full_name).decorate
    authorize @repo
  end

  def create
    @repo = Repo.new(full_name: full_name)
    authorize @repo

    if @repo.retrieve_from_github
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

    # TODO: Add specs for full_name_changed case
    if @repo.update_attributes(repo_params)
      @repo.retrieve_from_github if @repo.full_name_changed?
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

  # TODO: Specs
  def refresh
    authorize @repo, :staff_action?

    @repo.retrieve_from_github
    redirect_to repo_path(@repo), notice: 'Category has been refreshed.'
  end

  private

  # GET /repos/:owner/:name
  def full_name
    owner_and_name_from_params || full_name_from_params
  end

  def full_name_from_params
    params[:full_name] || (params[:repo] && params[:repo][:full_name])
  end

  def owner_and_name_from_params
    owner = params[:owner] || (params[:repo] && params[:repo][:owner])
    name  = params[:name]  || (params[:repo] && params[:repo][:name])
    (owner && name) ? "#{ owner }/#{ name }" : nil
  end

  def load_repo
    @repo = Repo.where(full_name: full_name).first!.decorate
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
