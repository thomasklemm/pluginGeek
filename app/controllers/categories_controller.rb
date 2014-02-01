class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :load_and_authorize_category

  def show
  end

  def new
    raise NotImplementedError
  end

  def create
    raise NotImplementedError
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category has been updated.'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to root_path, notice: 'Category has been destroyed.'
  end

  private

  def load_and_authorize_category
    @category = Category.find(params[:id])
    authorize @category
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: "Category '#{params[:id]}' could not be found."
  end

  def category_params
    params.require(:category).permit(policy(@category).permitted_attributes)
  end
end
