class RepoRelationship < ActiveRecord::Base
  belongs_to  :parent,
    class_name: 'Repo',
    touch: true
  belongs_to  :child,
    class_name: 'Repo',
    touch: true

  validates :parent,
            :child,
            presence: true
end
