class RobotsController < ApplicationController
  # No layout
  layout false

  # Render a robots.txt file based on whether the request
  # is performed against a canonical url or not
  # Prevent robots from indexing content served via a CDN twice
  def index
    if canonical_host?
      render 'allow'
    else
      render 'disallow'
    end
  end

  private

  def canonical_host?
    request.host == 'plugingeek.com'
  end
end
