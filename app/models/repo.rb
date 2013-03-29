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
#  name               :text
#  owner              :text
#  score              :integer          default(0)
#  staff_pick         :boolean          default(FALSE)
#  stars              :integer          default(0)
#  update_success     :boolean          default(FALSE)
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_repos_on_full_name  (full_name) UNIQUE
#  index_repos_on_score      (score)
#

class Repo < ActiveRecord::Base
  # Friendly ID
  extend FriendlyId
  friendly_id :full_name

  # Validations
  validates :full_name, presence: true, uniqueness: true
  # TODO: Some Github repos won't save, maybe a custom writer
  # that truncates descriptions would be worthwile
  validates :description, length: {maximum: 360}

  # Order repos by score
  scope :order_by_score, order('repos.score DESC')

  # FIXME: Improve performance, only select full_names
  def self.all_without(repo)
    order_by_score.select { |r| r.id != repo.id }
  end

  # Callbacks
  # Assign a repo's languages from its' categories' languages
  # on every save
  before_save :assign_languages

  # Retrieve record from Github if the full name changed
  # to handle renaming of repos and movements between owners
  after_save :update_from_github, if: :full_name_changed?

  # Defaults
  def stars
    self[:stars] || 0
  end

  def score
    self[:score] || 0
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
  # FIXME: Console shows this setup leaves orphan join records behind. Why? What's better to do?
  has_many :categorizations,
    dependent: :destroy
  has_many :categories,
    through: :categorizations,
    order: 'categories.score DESC'

  # Languages
  has_many :language_classifications,
    as: :classifier,
    dependent: :destroy
  has_many :languages,
    through: :language_classifications

  # Links
  has_many :link_relationships,
    as: :linkable,
    dependent: :destroy
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
    # Return early if category assignments don't change
    return unless new_list != category_list

    expire_categories_and_self # expire old categories

    full_category_names = prepare_category_list(new_list)
    assign_categories(full_category_names)

    expire_categories_and_self # expire new categories
  end

  # Update this very record from Github,
  #   live and in color
  def update_from_github
    return if Rails.env.test?
    RepoUpdater.new.perform(full_name)
  end

  def update_from_github(github)
    assign_fields_from_github(github)
    assign_score
    update_succeeded
    self.save
  end

  def update_succeeded!
    update_success? or self.update_column(:update_success, true)
    puts "Repo #{ full_name } has been updated successfully."
    true
  end

  def update_failed!(opts = {})
    persisted? and update_success? and self.update_column(:update_success, false)

    message = case opts[:reason]
      when :not_found_on_github
        "Repo #{ full_name } could not be found on Github."
      when :not_saved
        "Repo #{ full_name } could not be saved while updating from Github."
      else
        "Repo #{ full_name } could not be updated."
      end

    puts message
    false
  end

  private

  # Assign categories from a list of category names
  def assign_categories(full_category_names)
    self.categories = full_category_names.map do |full_name|
      Category.where(full_name: full_name).first_or_create!
    end
  end

  # Deduce languages from categories' languages
  def assign_languages
    self.languages = categories.flat_map(&:languages).uniq
  end

  def assign_fields_from_github(github)
    self.name                = github['name']
    self.owner               = github['owner']['login']
    self.github_description  = github['description']
    self.stars               = github['watchers']
    self.homepage_url        = github['homepage']
    self.github_updated_at   = github['pushed_at']
  end

  def prepare_category_list(list)
    list.gsub(', ', ',').split(',').select(&:present?).map(&:strip)
  end

  def last_updated
    Time.current - github_updated_at
  end

  def assign_score
    self.score = ((stars + 1) * activity).ceil
  end

  def activity
    2.0 - (last_updated / 12.months)
  end

  def update_succeeded
    self.update_success = true
  end

  def expire_categories_and_self
    categories.each(&:touch) and self.touch
  end
end
