class CategoryPolicy < ApplicationPolicy
  alias_method :show?,    :permit_guest
  alias_method :create?,  :permit_user
  alias_method :update?,  :permit_user
  alias_method :destroy?, :permit_staff_member

  def permitted_attributes
    if user.staff_member?
      [:name, :description, :draft, :featured, { related_category_ids: [] }]
    else
      [:description]
    end
  end
end
