class LinksController < ApplicationController
  # GET /links/new
  def new
    @link = Link.where(url: params[:url]).first_or_initialize
    # Set title and default published_at if link has just been initialized
    if @link.new_record?
      @link.title, @link.published_at = params[:title], Date.current
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links
  def create
    @link = Link.new(params[:link])

    if @link.save
      redirect_to edit_link_path(@link), notice: 'Saved link successfully.'
    else
      render action: :new
    end
  end

  # PUT /links/1
  def update
    @link = Link.find(params[:id])

    if @link.update_attributes(params[:link])
      redirect_to edit_link_path(@link), notice: 'Saved link successfully.'
    else
      render action: :edit
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to root_url, notice: 'Destroyed link.'
  end
end
