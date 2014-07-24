class Platform
  include ActiveModel::Model
  include Platform::StaticMethods

  attr_accessor :id, :name

  def id
    @id.to_s.parameterize('_')
  end
  alias_method :to_param, :id

  def == other
    id == other.id
  end

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
