module ApplicationHelper
  # Create a DNS prefetch tag
  def dns_prefetch_tag(url)
    "<link rel='dns-prefetch' href='#{ url }'>".html_safe
  end

  # Don't render sensitive content (like user info)
  # when the response headers indicate that the response
  # is to be cached in public caches (such as e.g. Rack::Cache)
  def response_publicly_cached?
    !!(response.cache_control[:public])
  end

  # TODO: Specs
  def icon_tag(type, text=nil)
    "<i class='icon-#{ type.to_s }'></i>#{ text }".html_safe
  end
end
