class Link::Relationship < ActiveRecord::Base
  belongs_to :link
  belongs_to :linkable, polymorphic: true
end
