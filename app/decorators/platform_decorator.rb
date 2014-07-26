class PlatformDecorator < Draper::Decorator
  delegate_all

  def platform_path
    global? ?
      h.global_platform_path :
      h.platform_path(id)
  end

  def platform_icon_path
    h.image_path("platforms/#{id}.png")
  end

  def icon_class
    case id
    when 'global' then 'github_badge'
    when 'ruby' then 'ruby'
    when 'javascript' then 'javascript'
    when 'html_css' then 'html5'
    when 'ios' then 'apple'
    when 'android' then 'android'
    end
  end
end
