class LinkPolicy < ApplicationPolicy
  alias_method :link, :record

  def maker
    maker = link && link.maker
    maker == user
  end

  def create?
    user
  end

  def update?
    user
  end

  def destroy?
    maker || staff
  end
end
