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
