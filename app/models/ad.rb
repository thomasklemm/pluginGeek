# == Schema Information
# Schema version: 20121217114014
#
# Table name: ads
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  url         :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  keyword     :string(255)
#

class Ad < ActiveRecord::Base
  ##
  # Categories
  has_many  :ad_categorizations
  has_many  :categories,
            through: :ad_categorizations

  ##
  # Validations
  # All string columns must be 255 chars at max
  validates :name, :description, :url,
    length: {maximum: 250}, presence: true

  ##
  # Attributes
  def name
    self[:name] && self[:name].html_safe
  end

  def description
    self[:description] && self[:description].html_safe
  end

  def keyword
    self[:keyword] && self[:keyword].html_safe
  end

  ##
  # Mass-Assignment protection
  # attr_accessible :description, :name, :url
end
