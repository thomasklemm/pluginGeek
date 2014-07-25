class Platform
  include ActiveModel::Model
  include Platform::IdMethods
  include Platform::StaticMethods

  attr_accessor :name

  def categories
    @categories ||= categories_scope
  end

  def categories_count
    categories_scope.count
  end

  private

  def categories_scope
    @categories_scope ||= Category.where(platform_id: id.to_s)
  end
end
