class LinkPolicy < ApplicationPolicy
  alias_method :link, :record

  alias_method :index?, :permit_moderator
  alias_method :create?, :permit_user
  alias_method :update?, :permit_user

  def destroy?
    permit_moderator || permit_submitter
  end

  def permitted_attributes
    user_attributes
  end

  private

  def permit_submitter
    link.submitter_id == user.id
  end

  def user_attributes
    [
      :title,
      :url,
      :category_ids => [],
      :repo_ids => []
    ]
  end
end
