class Category < ActiveRecord::Base

  # Mass Assignment Whitelist
  attr_accessible :description
  # Name only needs to be accessible in development and test environment
  attr_accessible :name if Rails.env.development? || Rails.env.test?

  # Friendly Id
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Default scope
  # Do not use default scoping
  # FIXME: Make a named scopt here for order: 'watcher_cont desc' and conditions: 'repo_count > 0'

  # Validation
  validates :name, uniqueness: true

end
