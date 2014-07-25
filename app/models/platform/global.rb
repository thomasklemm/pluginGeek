class Platform::Global
  include Singleton
  include Platform::Decoratable

  def self.global_id?(string)
    string.to_s == instance.id
  end

  def id
    'global'
  end

  def name
    'Global'
  end

  def global?
    true
  end

  def categories
    @categories ||= Category.all
  end

  def categories_count
    @categories_count ||= Category.count
  end
end
