class CategoriesController < ApplicationController

  before_filter :require_login, only: :update

  # GET root
  # GET /categories
  def index
    @tags = Category.visible.sort_by_watcher_count
  end

  # GET /categories/:id
  def show
    @tag = Category.find_by_slug(params[:id])

    @repos = Repo.tagged_with(@tag.name)
  end

  # PUT /categories/:id
  def update
    @tag = Category.find_by_slug(params[:id])

    if @tag.update_attributes(params[:category])
      flash[:notice] = 'Tag description updated.'
      redirect_to action: 'show'
    else
      flash[:alert] = 'Tag description could not be updated.'
      redirect_to action: 'show'
    end

  end

end
