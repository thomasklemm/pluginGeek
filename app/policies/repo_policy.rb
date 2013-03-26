class RepoPolicy < ApplicationPolicy
  def show?
    guest
  end

  def new?
    guest
  end

  def create?
    user
  end

  def update?
    user
  end

  def destroy?
    staff
  end
end
