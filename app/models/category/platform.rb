class Category::Platform < ActiveRecord::Base
  belongs_to :category

  def platform
    @platform ||= Platform.find(platform_id)
  end

  def platform=(new_platform)
    self.platform_id = new_platform.id
    @platform = new_platform
  end

end
