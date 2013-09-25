class LinkRelationship < ActiveRecord::Base
  belongs_to :link,
    touch: true
  belongs_to :linkable,
    polymorphic: true,
    touch: true
end
