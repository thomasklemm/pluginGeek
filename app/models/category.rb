class Category < ActiveRecord::Base

  # Friendly Id
  extend FriendlyId
  friendly_id :name_and_language, use: :slugged
  def name_and_language
    "#{name} - test"
  end

  # Tagging
  acts_as_taggable_on :tags, :languages

  # Scopes
  #   For default sorting and hiding of empty categories
  #   scope :order_wc, order('watcher_count desc')
  scope :order_ks, order('knight_score desc')
  scope :has_repos, where('repo_count > 0')
  scope :language, lambda { |language| tagged_with(language, on: :languages) }

  # Mass Assignment Whitelist
  attr_accessible :description

end
