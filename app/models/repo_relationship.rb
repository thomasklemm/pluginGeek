# == Schema Information
#
# Table name: repo_relationships
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  child_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RepoRelationship < ActiveRecord::Base
  belongs_to  :parent,
              class_name: 'Repo',
              touch: true
  belongs_to  :child,
              class_name: 'Repo',
              touch: true
end
