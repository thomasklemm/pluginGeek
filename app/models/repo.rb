class Repo < ActiveRecord::Base

  # Whitelisting attributes for mass assignment
  attr_accessible :full_name, :owner, :name
  # category_list only needs to be accessible in development (and maybe test) environment
  attr_accessible :category_list if Rails.env.development? || Rails.env.test?

  # Default scope
  default_scope order: 'watchers desc'

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

end
