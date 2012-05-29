class CategoriesController < ApplicationController
  def index
    @tags = Category.all
  end

  def show
    @tag = Category.find(params[:id])
    @repos = Repo.tagged_with(@tag.name)
  end
end
