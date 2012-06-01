class Category < ActiveRecord::Base

  # Mass Assignment Whitelist
  # FIXME: Name only needs to be accessible in development and test env
  attr_accessible :description, :name

  # Friendly Id
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Default scope
  default_scope order: 'watcher_count desc'

  # Validation
  validates :name, uniqueness: true

end
