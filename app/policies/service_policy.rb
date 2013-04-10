class ServicePolicy < ApplicationPolicy
  alias_method :index?,   :guest
  alias_method :show?,    :staff
  alias_method :new?,     :staff
  alias_method :create?,  :staff
  alias_method :edit?,    :staff
  alias_method :update?,  :staff
  alias_method :destroy?, :staff
end
