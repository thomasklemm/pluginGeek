module ApplicationHelper
  # Hide certain content like user details
  # when response is set to be cached in public caches
  # (such as e.g. Rack Cache)
  def response_publicly_cached?
    !!(response.cache_control[:public])
  end

  # DNS prefetch tag
  def dns_prefetch_tag(url)
    "<link rel='dns-prefetch' href='#{ url }'>"
  end

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
end
