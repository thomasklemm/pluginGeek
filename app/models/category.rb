class Category < ActiveRecord::Base
  attr_accessible :description

  def self.update
    tags = Repo.tag_counts_on(:categories)
    tags.each do |tag|
      category = Category.find_or_initialize_by_name(tag.name)
      category[:count] = tag.count
      category.save
    end
  end


end
