class RepoPolicy < ApplicationPolicy
  alias_method :show?,    :permit_guest
  alias_method :create?,  :permit_user
  alias_method :update?,  :permit_user
  alias_method :destroy?, :permit_staff_member
  alias_method :refresh?, :permit_staff_member

  def permitted_attributes
    if user.staff_member?
      [:full_name, :description, :category_list, :staff_pick, { parent_ids: [] }]
    else
      [:description, :category_list, { parent_ids: [] }]
    end
  end
end
