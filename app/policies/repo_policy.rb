class RepoPolicy < ApplicationPolicy
  alias_method :show?,    :permit_guest
  alias_method :new?,     :permit_guest
  alias_method :create?,  :permit_user
  alias_method :update?,  :permit_user
  alias_method :destroy?, :permit_moderator

  def permitted_attributes
    if moderator?
      [:owner_and_name, :staff_pick, { category_ids: [], parent_ids: [] }]
    else
      [{ category_ids: [], parent_ids: [] }]
    end
  end
end
