class RepoPolicy < ApplicationPolicy
  alias_method :repo, :record

  alias_method :show?,    :permit_guest
  alias_method :create?,  :permit_user
  alias_method :update?,  :permit_user
  alias_method :destroy?, :permit_moderator

  private

  def moderator_attributes
    [
      :owner_and_name,
      :staff_pick,
      :category_ids => [],
      :parent_ids => []
    ]
  end

  def user_attibutes
    [
      :category_ids => [],
      :parent_ids => []
    ]
  end
end
