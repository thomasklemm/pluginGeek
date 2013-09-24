class RepoPolicy < ApplicationPolicy
  alias_method :show?,    :permit_guest
  alias_method :create?,  :permit_user
  alias_method :update?,  :permit_user
  alias_method :destroy?, :permit_staff
end
