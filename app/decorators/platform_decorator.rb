class PlatformDecorator < Draper::Decorator
  delegate_all

  def platform_path
    all_platforms? ? h.root_path : h.platform_path(slug)
  end

  def platform_icon_path
    h.image_path("platforms/#{ slug }.png")
  end

  private

  def all_platforms?
    model.send(:all_platforms?)
  end
end
