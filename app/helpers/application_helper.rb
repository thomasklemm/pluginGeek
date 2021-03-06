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

  def icon_tag(type, text=nil)
    "<i class='icon-#{ type.to_s }'></i>#{ text }".html_safe
  end

  def markdown(text)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, options).render(text).html_safe
  end
end
