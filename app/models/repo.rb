# == Schema Information
#
# Table name: repos
#
#  created_at         :datetime         not null
#  description        :text
#  full_name          :text             not null
#  github_description :text
#  github_updated_at  :datetime
#  homepage_url       :text
#  id                 :integer          not null, primary key
#  knight_score       :integer          default(0)
#  name               :text
#  owner              :text
#  staff_pick         :boolean          default(FALSE)
#  stars              :integer          default(0)
#  update_success     :boolean          default(FALSE)
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_repos_on_full_name     (full_name) UNIQUE
#  index_repos_on_knight_score  (knight_score)
#

class Repo < ActiveRecord::Base
  # Friendly ID
  extend FriendlyId
  friendly_id :full_name

  # Validations
  validates :full_name, presence: true, uniqueness: true
  validates :description, length: {maximum: 360}

  # Audits
  audited only: [:description]

  # Order repos by score
  scope :order_by_score, order('repos.knight_score DESC')

  # All repos except the given one,
  # so that parent cannot be set to self in repo#edit
  def self.all_except(repo)
    order_by_score.to_a - [repo]
  end

  # Callbacks
  # Assign a repo's languages from its' categories' languages
  # on every save
  before_save :assign_languages

  # Changes in repo (e.g. adding staff pick flag) need
  # to expire associated categories
  after_save :expire_categories
  after_save :expire_parents_and_children

  # Retrieve record from Github if the full name changed
  # to handle renaming of repos and movements between owners
  after_save :update_from_github, if: :full_name_changed?

  # Defaults
  def stars
    self[:stars] || 0
  end

  def knight_score
    self[:knight_score] || 0
  end

  # Parents
  has_many :parent_child_relationships,
    class_name:   'RepoRelationship',
    foreign_key:  :child_id,
    dependent:    :destroy
  has_many :parents,
    through:      :parent_child_relationships,
    source:       :parent

  # Children
  has_many :child_parent_relationships,
    class_name:   'RepoRelationship',
    foreign_key:  :parent_id,
    dependent:    :destroy
  has_many :children,
    through:      :child_parent_relationships,
    source:       :child

  def parents_and_children
    parents | children
  end

  # Categories
  has_many :categorizations
  has_many :categories,
    through: :categorizations,
    order: 'categories.knight_score DESC'

  # Languages
  has_many :language_classifications,
    as: :classifier
  has_many :languages,
    through: :language_classifications

  # Links
  has_many :link_relationships,
    as: :linkable
  has_many :links,
    through: :link_relationships,
    uniq: true

 # Lists for tag inputs
  def child_list
    children.map(&:full_name).join(', ')
  end

  def language_list
    languages.map(&:name).join(', ')
  end

  def category_list
    categories.map(&:full_name).join(', ')
  end

  # Handle tag input changes
  def category_list=(new_list)
    # Early return if category assignments don't change
    return unless new_list != category_list

    # Expire old categories
    categories.each(&:touch)

    full_names = new_list.split(', ').select(&:present?).map(&:strip)

    self.categories = full_names.map do |full_name|
      Category.where(full_name: full_name).first_or_create!
    end

    # Expire new categories and self
    categories.each(&:touch) and self.touch
  end

  # Update this very record from Github,
  #   live and in color
  def update_from_github
    return if Rails.env.test?
    RepoUpdater.new.perform(full_name)
  end

  private

  # Deduce languages from categories' languages
  def assign_languages
    self.languages = categories.flat_map(&:languages).uniq
  end

  def expire_categories
    categories.each(&:touch)
  end

  def expire_parents_and_children
    parents_and_children.each(&:touch)
  end

  # Whitelisting attributes for mass assignment
  attr_accessible :full_name, :description, :category_list, :parent_ids, :staff_pick
end
