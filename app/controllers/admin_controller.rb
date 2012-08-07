class AdminController < ApplicationController
  # HTTP Basic Authentication
  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_SECRET']

  def index
  end
end
