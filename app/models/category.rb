# == Schema Information
#
# Table name: categories
#
#  created_at       :datetime         not null
#  description      :text
#  draft            :boolean          default(TRUE)
#  full_name        :text             not null
#  id               :integer          not null, primary key
#  knight_score     :integer          default(0)
#  long_description :text
#  slug             :text             not null
#  stars            :integer          default(0)
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_categories_on_knight_score  (knight_score)
#  index_categories_on_slug          (slug) UNIQUE
#

class Category < ActiveRecord::Base
  # Friendly Id using history module (redirecting to new slug if slug changed)
  extend FriendlyId
  friendly_id :full_name, use: [:slugged, :history]

  # Validations
  validates :full_name, :slug, uniqueness: true
  validates :description, length: {maximum: 360}

  # Audits
  audited only: [:full_name, :description]

  # Order categories by score
  scope :order_by_score, order('categories.knight_score DESC')

  # Assign aggregate stars of repos as category stars
  before_save :assign_stars

  # Assign aggregate scores of repos as category score
  before_save :assign_score

  # Assign languages from full_name
  before_save :assign_languages

  # Update the languages of the associated repos
  # and expire the repos
  after_commit :update_repo_languages

  # Repos
  has_many :categorizations
  has_many :repos,
    through: :categorizations,
    order: 'repos.knight_score DESC'

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
    order: 'links.published_at DESC'

  # Ads
  has_many :ad_categorizations
  has_many :ads,
    through: :ad_categorizations

  # Similar categories
  has_many :category_relationships,
    foreign_key: :other_category_id

  has_many :reverse_category_relationships,
    class_name: 'CategoryRelationship',
    foreign_key: :category_id

  has_many :related_categories,
    through: :category_relationships,
    source: :category

  has_many :reverse_related_categories,
    through: :reverse_category_relationships,
    source: :other_category

  def similar_categories
    (related_categories | reverse_related_categories).uniq
  end

  private

  # Assign aggregate stars of repos as category stars
  def assign_stars
    self.stars = repos.map(&:stars).reduce(:+) || 0
  end

  # Assign aggregate scores of repos as category score
  def assign_score
    self.knight_score = repos.map(&:knight_score).reduce(:+) || 0
  end

  # Assign languages from full_name
  def assign_languages
    return unless full_name.changed?

    # Extract languages from full_name string
    match_data = full_name.match %r{\((?<languages>.*)\)}
    return unless match_data.present?

    langs = match_data[:languages].downcase.split('/').map(&:strip)
    return unless langs.present?

    # Reset languages
    self.languages = []

    # Set provided languages if they are known
    langs.each do |lang|
      language = Language.find_by_slug(lang)
      self.languages << language if language
    end

    #  Assign sublanguages if appropriate
    assign_web_languages if langs.include?('web')
    assign_mobile_languages if langs.include?('mobile')
  end

  def assign_web_languages
    Language::Web.each do |lang|
      language = Language.find_by_slug(lang)
      self.languages << language if language
    end
  end

  def assign_mobile_languages
    Language::Mobile.each do |lang|
      language = Language.find_by_slug(lang)
      self.languages << language if language
    end
  end

  # Update languages of each associated repo
  # and expire repos
  def update_repo_languages
    repos(true).each { |repo| repo.save }
  end

  # Mass Assignment Whitelist
  attr_accessible :full_name, :description, :draft
end
