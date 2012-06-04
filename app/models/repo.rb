class Repo < ActiveRecord::Base

  # Whitelisting attributes for mass assignment
  attr_accessible :full_name, :owner, :name
  # category_list only needs to be accessible in development (and maybe test) environment
  attr_accessible :category_list if Rails.env.development? || Rails.env.test?

  # Default scope
  default_scope order: 'knight_score desc'

  # Validations
  validates :full_name, uniqueness: true

  # FriendlyId
  extend FriendlyId
  friendly_id :full_name

  # Tagging
  acts_as_ordered_taggable_on :categories

  # Attribute defaults
  def description
    self[:description] or "No description given."
  end

  def homepage_url
    self[:homepage_url] or ""
  end

  ###
  #   Updating Jobs
  ###

  # Send 'initialize_repo_from_github' to (new) Repo object
  def initialize_repo_from_github
    if Updater.initialize_repo_from_github(full_name)
      # success
      true
    else
      # error
      false
    end
  end

end
