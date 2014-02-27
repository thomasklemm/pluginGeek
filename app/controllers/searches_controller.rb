class SearchesController < ApplicationController
  def search
    @search = Search.new(params[:q])
  end
end
