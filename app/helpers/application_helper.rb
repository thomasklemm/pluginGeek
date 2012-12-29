module ApplicationHelper
  def eye_catcher_message
    case params[:language]
      when /ruby/ then "So you're looking <br />for some awesome <span class='type'>Ruby Gems?</span>"
      when /javascript/ then "So you're looking <br />for some awesome <span class='type'>Javascript Plugins?<span>"
      when /webdesign/ then "So you're looking <br />for some great <span class='type'>Webdesign Inspiration?</span>"
      when /mobile|ios|android/ then "So you're looking <br />for some handy <span class='type'>Mobile Development Plugins?<span>"
      else "So you're looking <br />for some awesome <span class='type'>Webdevelopment Plugins?<span>"
      end
  end

  def public_caching?
    !!(response.cache_control[:public])
  end
end
