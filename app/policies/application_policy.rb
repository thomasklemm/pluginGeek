ApplicationPolicy = Struct.new(:user, :record) do
  ##
  # Permission levels

  def permit_guest
    true
  end

  def permit_user
    user
  end

  def permit_moderator
    moderator?
  end

  ##
  # Defaults

  def index?
    false
  end

  def show?
    false
  end

  def new?
    create?
  end

  def create?
    false
  end

  def edit?
    update?
  end

  def update?
    false
  end

  def destroy?
    false
  end

  private

  def moderator?
    user && user.moderator?
  end
end