# == Schema Information
# Schema version: 20121217114014
#
# Table name: repo_relationships
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  child_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_repo_relationships_on_child_id   (child_id)
#  index_repo_relationships_on_parent_id  (parent_id)
#

class RepoRelationship < ActiveRecord::Base
  belongs_to  :parent,
    class_name: 'Repo',
    touch: true

  belongs_to  :child,
    class_name: 'Repo',
    touch: true
end
