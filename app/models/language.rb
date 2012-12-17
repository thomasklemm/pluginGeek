# == Schema Information
# Schema version: 20121217114014
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  slug       :string(255)
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_languages_on_slug  (slug) UNIQUE
#

class Language < ActiveRecord::Base
  # FriendlyId
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Hierarchy
  acts_as_tree

  attr_accessible :name
end
