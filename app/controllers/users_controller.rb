class UsersController < ApplicationController
  def debug
    SwiftypeReindexWorker.new.perform('Category')
  end
end
