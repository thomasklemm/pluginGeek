class LinkRelationship < ActiveRecord::Base
  belongs_to :link
  belongs_to :linkable, polymorphic: true
end
