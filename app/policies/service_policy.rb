class ServicePolicy < ApplicationPolicy
  alias_method :show?,    :permit_staff
  alias_method :create?,  :permit_staff
  alias_method :update?,  :permit_staff
  alias_method :destroy?, :permit_staff
end
