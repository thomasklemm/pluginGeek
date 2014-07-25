class PlatformDecorator < Draper::Decorator
  delegate_all

  def platform_path
    global? ?
      h.root_path :
      h.platform_path(id)
  end

  def platform_icon_path
    h.image_path("platforms/#{id}.png")
  end
end
