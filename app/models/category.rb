# == Schema Information
#
# Table name: categories
#
#  all_repos     :text
#  created_at    :datetime         not null
#  description   :text
#  id            :integer          not null, primary key
#  knight_score  :integer
#  label         :string(255)
#  name          :string(255)
#  popular_repos :string(255)
#  repo_count    :integer
#  slug          :string(255)
#  updated_at    :datetime         not null
#  watcher_count :integer
#
# Indexes
#
#  index_categories_on_slug  (slug) UNIQUE
#

class Category < ActiveRecord::Base

  # Friendly Id
  #   using history module (redirecting to new slug if slug changed)
  #   First language is considered to be main language
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  # Tagging
  acts_as_ordered_taggable_on :tags, :languages

  # Scopes
  #   Tagged with language or all depending on presence of language
  scope :tagged_with_language, lambda { |language| tagged_with(language.downcase, on: :languages) if language.present? }
  #   Visibility only of categories that have repos associated with them
  scope :has_repos, where('repo_count > 0')
  #   Order
  scope :order_knight_score, order('knight_score desc')
  scope :order_watcher_count, order('watcher_count desc')
  #   Attribute Selections
  scope :overview_attributes, select([:name, :slug, :watcher_count, :label, :short_description, :repo_count, :popular_repos, :all_repos, :knight_score])

  # Validations
  after_validation :move_friendly_id_error_to_name
  def move_friendly_id_error_to_name
    errors.messages[:name] = errors.messages.delete(:friendly_id)
  end

  # Mass Assignment Whitelist
  attr_accessible :description

  # Attribute Defaults
  def description
   self[:description].present? ? self[:description] : " "
  end

  def short_description
   self[:short_description].present? ? self[:short_description] : " "
  end
end
