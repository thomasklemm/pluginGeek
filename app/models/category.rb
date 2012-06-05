class Category < ActiveRecord::Base

  # Mass Assignment Whitelist
  attr_accessible :description
  # Name only needs to be accessible in development and test environment
  attr_accessible :name if Rails.env.development? || Rails.env.test?

  # Friendly Id
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Scopes
  #   For default sorting and hiding of empty categories
  scope :sort_by_watcher_count, order('watcher_count desc')
  scope :sort_by_knight_score, order('knight_score desc')
  scope :visible, where('repo_count > 0')

  # Validation
  validates :name, uniqueness: true

end
