class CategoriesController < ApplicationController

  before_filter :require_login, only: [:edit, :update]

  # GET /categories
  def index
    # Find categories (all or limited to language)
    @categories = Category.tagged_with_language(params[:language]).load_overview_attributes.order_knight_score
  end

  # GET /categories/:id
  def show
    # friendly_id's slug serves as params[:id]
    @category = Category.find(params[:id])

    # If an old id or a numeric id was used to find the record, then
    #   the request path will not match the category_path, and we should do
    #   a 301 redirect that uses the current friendly id.
    #   (Source: friendly_id docs)
    if request.path != category_path(@category)
      return redirect_to @category, status: :moved_permanently
    end

    @repos = Repo.tagged_with(@category.name, on: :categories).order_knight_score
  end

  # GET /categories/:id/edit
  def edit
    @category = Category.find(params[:id])
    @repos = Repo.tagged_with(@category.name, on: :categories).order_knight_score
    render action: :show
  end

  # PUT /categories/:id
  def update
    @category = Category.find(params[:id])

    # Short Description: Render Markdown & Strip Tags & Squish 
    #  To remove links and emphasis if someone accidentally inputs markdown or mischiefiously inputs <script> tags
    params[:category][:short_description] &&= view_context.strip_tags(markdown.render(params[:category][:short_description])).squish

    if @category.update_attributes(params[:category])
      # Render Markdown Description and save as description
      @category.description = markdown.render(@category.md_description)
       if @category.save
        flash[:notice] = 'Category updated. Thanks a lot!'
        redirect_to action: 'show'
      else
        flash[:alert] = 'Markdown rendering failed. Please alert me if you see this.'
        redirect_to action: 'show'
      end
      
    else
      flash[:alert] = "Category update failed. Please let me know if you assume this is a bug."
      redirect_to action: 'show'
    end
  end

protected

  def markdown
    # See Redcarpet options: https://github.com/tanoku/redcarpet
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, safe_links_only: true, with_toc_data: true, hard_wrap: true, no_intra_emphasis: true, autolink: true)
  end

end
