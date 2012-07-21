# == Schema Information
#
# Table name: repos
#
#  children          :string(255)
#  created_at        :datetime         not null
#  description       :string(255)
#  forks             :integer
#  full_name         :string(255)
#  github_updated_at :datetime
#  github_url        :string(255)
#  homepage_url      :string(255)
#  id                :integer          not null, primary key
#  knight_score      :integer
#  label             :string(255)
#  name              :string(255)
#  owner             :string(255)
#  updated_at        :datetime         not null
#  watchers          :integer
#
# Indexes
#
#  index_repos_on_full_name  (full_name) UNIQUE
#

class Repo < ActiveRecord::Base

  # Scopes
  #   Order
  scope :order_knight_score, order('knight_score desc')

  # Validations
  validates :full_name, uniqueness: true

  # FriendlyId
  extend FriendlyId
  friendly_id :full_name

  # Tagging
  acts_as_ordered_taggable_on :categories

  # Whitelisting attributes for mass assignment
  attr_accessible :full_name, :category_list

  # Attribute defaults

  def name
    self[:name] or self[:full_name].split('/')[1]
  end

  def owner
    self[:name] or self[:full_name].split('/')[0]
  end

  def description
    self[:description] or "No description. Add one on Github."
  end

  def homepage_url
    self[:homepage_url] or ""
  end

  def github_updated_at
    self[:github_updated_at] or (Time.now - 2.years)
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
