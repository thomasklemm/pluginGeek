class LinkPolicy < ApplicationPolicy
  alias_method :link, :record

  alias_method :create?, :permit_user
  alias_method :update?, :permit_user

  def destroy?
    permit_submitter || permit_staff
  end

  private

  def permit_submitter
    (link && link.submitter) == user
  end
end
