class Category < ActiveRecord::Base

  # Mass Assignment Whitelist
  # FIXME: Name only needs to be accessible in development and test env
  attr_accessible :description, :name

  # Friendly Id
  extend FriendlyId
  friendly_id :name, use: :slugged

  # Default scope
  default_scope order: 'watcher_count desc'


  # Update Category table job
  def self.update
    tags = Repo.tag_counts_on(:categories)

    tags.each do |tag|
      category = self.find_or_initialize_by_name(tag.name)

      # Popular Repos and All Repos (String)
      repos = Repo.tagged_with(tag)

      # Popular Repos
      popular_repos = []
      repos[0..3].each { |repo| popular_repos << repo.full_name }
      category[:popular_repos] = popular_repos.join(", ")

      # All Repos
      # REVIEW: maybe only list those repos that are not in popular_repos
      all_repos = []
      repos.each { |repo| all_repos << repo.full_name }
      category[:all_repos] = popular_repos.join(", ")

      # Repo Count
      category[:repo_count] = tag.count

      # Watcher Count
      category[:watcher_count] = repos.sum(&:watchers)
      # category[:watcher_count] = repos.sum { |repo| repo.watchers }

      # Save category
      category.save
    end
  end


end
