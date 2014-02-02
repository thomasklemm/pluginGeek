class PlatformsController < ApplicationController
  def show
    @platform = Platform.find_by!(slug: params[:id])
    redirect_to [@platform, :categories]
  end
end
