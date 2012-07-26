# == Schema Information
#
# Table name: ads
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  url         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Ad < ActiveRecord::Base

  ###
  #   Modules
  ###

  # Tagging
  acts_as_taggable_on :categories

  # Empty Mass-Assignment Whitelist
  attr_accessible
end
