class CategoryPolicy < ApplicationPolicy
  alias_method :show?,    :permit_guest
  alias_method :create?,  :permit_moderator
  alias_method :update?,  :permit_user
  alias_method :destroy?, :permit_moderator

  def permitted_attributes
    if moderator?
      [:name, :description, :draft, { related_category_ids: [] }]
    else
      [:description]
    end
  end
end
