module ApplicationHelper
  # Deliver a custom EyeCatcher message
  # to viewers of a certain language
  def eye_catcher_message
    case params[:language]
      when /ruby/ then "So you're looking <br />for some awesome <span class='type'>Ruby Gems?</span>"
      when /javascript/ then "So you're looking <br />for some awesome <span class='type'>Javascript Plugins?<span>"
      when /webdesign/ then "So you're looking <br />for some great <span class='type'>Webdesign Inspiration?</span>"
      when /mobile|ios|android/ then "So you're looking <br />for some handy <span class='type'>Mobile Development Plugins?<span>"
      else "So you're looking <br />for some awesome <span class='type'>Webdevelopment Plugins?<span>"
      end
  end

  # Hide certain content like user details
  # when response is set to be cached in public caches
  # (such as e.g. Rack Cache)
  def public_caching?
    !!(response.cache_control[:public])
  end

  # Hide links to edit-actions when already on edit pages
  def edit_action?
    !!(params[:action] == 'edit')
  end

  # Only display user details if current_user is present
  def current_user?
    current_user.present?
  end
end
