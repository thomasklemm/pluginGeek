class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  ##
  # Permission levels

  def permit_guest
    true
  end

  def permit_user
    user
  end

  def permit_staff_member
    user && user.staff_member?
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
end

