# == Schema Information
# Schema version: 20130104093506
#
# Table name: links
#
#  id           :integer          not null, primary key
#  url          :string(255)
#  title        :string(255)
#  author       :string(255)
#  author_url   :string(255)
#  published_at :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Link < ActiveRecord::Base
  validates :url, :title, presence: true
  attr_accessible :author, :author_url, :published_at, :title, :url
end
