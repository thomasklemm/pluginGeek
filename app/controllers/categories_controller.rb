class CategoriesController < ApplicationController

  before_filter :require_login, only: :update

  # GET root
  # GET /categories
  def index
    @categories = Category.visible.sort_by_watcher_count
  end

  # GET /categories/:id
  def show
    @category = Category.find_by_slug(params[:id])

    @repos = Repo.tagged_with(@category.name)
  end

  # PUT /categories/:id
  def update
    @category = Category.find_by_slug(params[:id])

    if @category.update_attributes(params[:category])
      flash[:notice] = 'Category description updated.'
      redirect_to action: 'show'
    else
      flash[:alert] = 'Category description could not be updated.'
      redirect_to action: 'show'
    end

  end

end
