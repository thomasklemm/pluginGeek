class CategoriesController < ApplicationController

  # Make sure categories are up to date
  #   by running Updater.update_catgories_from_repos every now and then

  def index
    @tags = Category.all
  end

  def show
    @tag = Category.find_by_slug(params[:id])
    @repos = Repo.tagged_with(@tag.name)
  end

  def update
    @tag = Category.find_by_slug(params[:id])
    @tag.update_attributes(params[:category])
    redirect_to action: 'show'
  end

end
