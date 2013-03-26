class LinkPolicy < ApplicationPolicy
  def submitter
    link.submitter_id == user.id
  end

  def new?
    user
  end

  def create?
    user
  end

  def update?
    user
  end

  def destroy?
    submitter || staff
  end
end
