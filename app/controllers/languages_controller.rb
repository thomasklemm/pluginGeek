class LanguagesController < ApplicationController
  def show
    @language = Language.find_by!(name: params[:id])
  end
end
