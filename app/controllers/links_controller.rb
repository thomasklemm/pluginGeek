class LinksController < ApplicationController
  # GET /links
  def index
    @links = Link.all
  end

  # GET /links/new
  def new
    @link = Link.new(
      url: params[:url],
      title: params[:title],
      published_at: Date.current
    )
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links
  def create
    @link = Link.new(params[:link])

    if @link.save
      redirect_to edit_link_path(@link), notice: 'Link was successfully created. Please add projects and categories now.'
    else
      render action: :new
    end
  end

  # PUT /links/1
  def update
    @link = Link.find(params[:id])

    if @link.update_attributes(params[:link])
      redirect_to @link, notice: 'Link was successfully updated.'
    else
      render action: :edit
    end
  end
end
