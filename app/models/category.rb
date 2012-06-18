class Category < ActiveRecord::Base

  # Friendly Id
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  # Tagging
  acts_as_taggable_on :tags, :languages

  # Scopes
  #   For default sorting and hiding of empty categories
  #   scope :order_wc, order('watcher_count desc')
  scope :order_ks, order('knight_score desc')
  scope :has_repos, where('repo_count > 0')
  scope :language, lambda { |language| tagged_with(language, on: :languages) }

  # Validations
  after_validation :move_friendly_id_error_to_name

  def move_friendly_id_error_to_name
    errors.messages[:name] = errors.messages.delete(:friendly_id)
  end

  # Mass Assignment Whitelist
  attr_accessible :description

end
