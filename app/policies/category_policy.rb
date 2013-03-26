class CategoryPolicy < ApplicationPolicy
  def index?
    guest
  end

  def show?
    guest
  end

  def update?
    user
  end

  def destroy?
    staff
  end
end
