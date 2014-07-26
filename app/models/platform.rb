class Platform
  include ActiveModel::Model
  include Platform::IdMethods
  include Platform::StaticMethods
  include Platform::Decoratable

  attr_accessor :name, :icon_class

  def categories
    @categories ||= categories_scope
  end

  def categories_count
    categories_scope.count
  end

  def self.for_navigation
    [global] + all
  end

  def global?
    false
  end

  private

  def categories_scope
    @categories_scope ||= Category.where("? = ANY(platform_ids)", id)
  end
end
