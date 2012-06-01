class Category < ActiveRecord::Base

  # Mass Assignment Whitelist
  attr_accessible :description
  # Name only needs to be accessible in development and test environment
  attr_accessible :name if Rails.env.development? || Rails.env.test?

  # Friendly Id
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Default scope
  default_scope order: 'watcher_count desc'

  # Validation
  validates :name, uniqueness: true

end
