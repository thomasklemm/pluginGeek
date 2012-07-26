# == Schema Information
#
# Table name: repos
#
#  id                :integer          not null, primary key
#  full_name         :string(255)
#  owner             :string(255)
#  name              :string(255)
#  watchers          :integer
#  forks             :integer
#  description       :string(255)
#  github_url        :string(255)
#  homepage_url      :string(255)
#  knight_score      :integer
#  github_updated_at :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  label             :string(255)
#  children          :string(255)
#

class Repo < ActiveRecord::Base
  ###
  #   Module Extensions
  ###
  # FriendlyId
  extend FriendlyId
  friendly_id :full_name

  # Tagging
  acts_as_ordered_taggable_on :categories
  acts_as_taggable_on :languages

  ###
  #   Scoping / Scopes & Validations
  ###
  # find_all_by_language('ruby'),
  #   order by knight_score
  scope :find_all_by_language, lambda {  |language| tagged_with(language, on: :languages).order_by_knight_score }
  # find_all_by_category('awesome_category'),
  #   order by knight_score
  scope :find_all_by_category, lambda { |category_name| tagged_with(category_name, on: :categories).order_by_knight_score }
  # order_by_knight_score,
  #   order repos by descending knight_score
  scope :order_by_knight_score, order('knight_score desc')

  # Validations
  validates :full_name, uniqueness: true

  ###
  #   Field Defaults
  ###
  def name
    self[:name] or self[:full_name].split('/')[1]
  end

  def owner
    self[:owner] or self[:full_name].split('/')[0]
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
  #   Life-Cycle Callbacks
  ###
  # Touch parents after safe
  #   cache auto-expiration
  after_save :touch_parents
  def touch_parents
    parents = Repo.where("children LIKE ?", "%#{ full_name }%")
    parents.each { |p| p.touch }
  end

  # Determine Languages
  before_save :determine_languages
  def determine_languages
    languages_array = []
    categories.each do |c|
      match = /\((?<languages>.*)\)/.match(c.name)
      # if there is not match, match will be nil
      languages_string = match[:languages] if match
      (languages_array << languages_string.split('/').join(', ').downcase) if languages_string
    end
    self.language_list = languages_array.join(', ')
  end

  # Whitelisting attributes for mass assignment
  attr_accessible :full_name, :category_list
end
