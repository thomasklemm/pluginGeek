class Navigation < Struct.new(:slug, :name, :path, :icon_path, :css_classes)

  def items
  end

  RUBY = new(:ruby, 'Ruby', platform_path(:ruby), nil, nil)

  def self.platform_path(slug)
    Rails.application.routes.url_helpers.platform_path(slug)
  end
end