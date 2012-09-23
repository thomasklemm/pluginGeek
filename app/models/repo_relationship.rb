class RepoRelationship < ActiveRecord::Base
  attr_accessible :child_id, :parent_id
end
