# == Schema Information
#
# Table name: link_relationships
#
#  created_at    :datetime         not null
#  id            :integer          not null, primary key
#  link_id       :integer          not null
#  linkable_id   :integer          not null
#  linkable_type :text             not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_link_relationships_on_link_id   (link_id)
#  index_link_relationships_on_linkable  (linkable_id,linkable_type)
#

class LinkRelationship < ActiveRecord::Base
  belongs_to :link
  belongs_to :linkable,
    polymorphic: true

  validates :link, :linkable, presence: true
end
