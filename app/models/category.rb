class Category < ActiveRecord::Base

  # Mass Assignment Whitelist
  attr_accessible :description

  # Friendly Id
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Job to update Category table
  def self.update
    tags = Repo.tag_counts_on(:categories)
    tags.each do |tag|
      category = self.find_or_initialize_by_name(tag.name)
      
      category[:count] = tag.count

      repos = Repo.tagged_with(tag).limit(4)

      popular_repos = []
      repos.each do |repo|
        popular_repos << repo.full_name
      end
      category[:popular_repos] = popular_repos.join(", ")

      category.save
    end
  end


end
