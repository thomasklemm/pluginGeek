class Platform::Global
  include Singleton

  def self.global_id?(string)
    string.to_s == instance.id
  end

  def id
    'global'
  end

  def name
    'Global'
  end

  def categories
    Category.all
  end

  def categories_count
    Category.count
  end
end
