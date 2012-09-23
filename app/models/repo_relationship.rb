class RepoRelationship < ActiveRecord::Base
  belongs_to :parent, class_name: 'Repo'
  belongs_to :child,  class_name: 'Repo'
end
