class ReposController < ApplicationController
  # Filters
  before_filter :find_language, only: :index

  before_filter :find_or_initialize_repo, only: [:show, :create, :edit, :update]
  before_filter :authenticate_user!, only: [:edit, :update]

  # NOTE: not mapped in routing currently
  def index
    @repos = @language.repos.includes(:children)
  end

  # GET /repos/:owner/:name(/*leftover)
  def show
    # Render view that allows to add a repo if it isn't known yet
    @repo.new_record? and render 'add_a_new_repo'

    # Redirect to base url (remains might be attached when clicking bookmarklet on github repo's wiki page...)
    params[:remains] and return redirect_to @repo
  end

  # POST /repos/:owner/:name
  def create
    if RepoUpdater.new.perform(@repo.full_name)
      # Reload for correct redirection path
      @repo = Repo.find_by_full_name(@repo.full_name)

      flash[:notice] ||= "Added repo '#{ @repo.full_name }'. Add categories so that people can find it."
      redirect_to @repo
    else
      flash[:alert] = "Failed to add repo '#{ @repo.full_name }'."
      redirect_to root_path
    end
  end

  # GET /repos/:owner/:name/edit
  def edit
  end

  # PUT /repos/:owner/:name
  def update
    params[:repo][:category_list] &&= params[:repo][:category_list].split(',').join(', ')

    if @repo.update_attributes(params[:repo])
      flash[:notice] = 'Repo saved.'
      redirect_to @repo
    else
      flash.now.alert = 'Some validation errors occured.'
      render action: :edit
    end
  end

protected

  def find_language
    @language = Language.find(params[:language])
  end

  def find_or_initialize_repo
    @repo = Repo.where(full_name: full_name_from_params).first_or_initialize
  end

  def full_name_from_params(owner = params[:owner], name = params[:name])
    "#{owner}/#{name}"
  end
end
