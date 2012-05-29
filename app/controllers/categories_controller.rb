class CategoriesController < ApplicationController
  def index
    # REVIEW: The update call should be more efficiently done,
    #   e.g. once every minute in the background only on objects that changed
    Category.update
    @tags = Category.all
  end

  def show
    @tag = Category.find_by_slug(params[:id])
    @repos = Repo.tagged_with(@tag.name)
  end
end
