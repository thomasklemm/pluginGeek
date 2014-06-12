class CategoryPolicy < ApplicationPolicy
  alias_method :category, :record

  alias_method :show?,    :permit_guest
  alias_method :create?,  :permit_moderator
  alias_method :update?,  :permit_moderator
  alias_method :destroy?, :permit_moderator

  private

  def moderator_attributes
    [
      :name,
      :description,
      :published,
      :platform_ids => [],
      :related_category_ids => []
    ]
  end

  def user_attributes
    []
  end
end
