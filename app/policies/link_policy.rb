class LinkPolicy < ApplicationPolicy
  alias_method :link, :record

  alias_method :index?, :permit_moderator
  alias_method :create?, :permit_user
  alias_method :update?, :permit_user

  def destroy?
    permit_moderator || permit_submitter
  end

  def permitted_attributes
    [
      :title,
      :url,
      :category_ids => [],
      :repo_ids => []
    ]
  end

  private

  def permit_submitter
    (link && link.submitter) == user
  end
end
