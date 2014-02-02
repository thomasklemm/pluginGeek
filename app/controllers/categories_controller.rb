class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_category, only: [:show, :edit, :update, :destroy]

  def index
    @platform = Platform.find_by!(slug: params[:platform_id])
    @categories = @platform.categories
  end

  def show
  end

  def new
    @category = Category.new
    authorize @category
  end

  def create
    @category = Category.new(category_params)
    authorize @category

    if @category.save
      redirect_to @category, notice: 'Category has been created.'
    else
      render :new
    end
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

  def load_category
    @category = Category.find(params[:id])
    authorize @category
  end

  def category_params
    params.
      require(:category).
      permit(policy(@category).permitted_attributes)
  end
end
