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
  scope :tagged_with_language, lambda { |language| tagged_with(language, on: :languages) if language.present? && language != 'www' }

  #   Visibility only of categories that have repos associated with them
  scope :has_repos, where('repo_count > 0')

  #   Order
  scope :order_knight_score, order('knight_score desc')
  scope :order_watcher_count, order('watcher_count desc')

  # Validations
  after_validation :move_friendly_id_error_to_name
  def move_friendly_id_error_to_name
    errors.messages[:name] = errors.messages.delete(:friendly_id)
  end

  # Mass Assignment Whitelist
  attr_accessible :description

end
