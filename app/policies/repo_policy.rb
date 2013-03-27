class RepoPolicy < ApplicationPolicy
  def index?
    guest
  end

  def show?
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
