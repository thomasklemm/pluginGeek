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

  def create
  end

end
