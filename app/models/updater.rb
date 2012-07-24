class Updater

  ###
  #   Repos
  ###

  # Update Knight
  #   a) Update Repos
  #   b) Update Categories
  def self.update_knight
    Rails.logger.info 'Processing Updater.update_knight...'
    update_repos_from_github
    update_categories_from_repos
    Rails.logger.info 'Finished processing Updater.update_knight'
  end

  # Update Repos from Github asynchronously
  def self.update_repos_from_github
    Rails.logger.info 'Scheduling all repos to be updated by Sidekiq...'
    Repo.pluck(:full_name).each { |repo_id| RepoUpdater.perform_async(repo_id) }
    Rails.logger.info 'Finished scheduling all repos to be updated by Sidekiq'
  end

  # Update Categories from Repos asynchrounously
  def self.update_categories_from_repos
    Rails.logger.info 'Scheduling categories to be updated by Sidekiq...'
    CategoriesUpdater.perform_async
    Rails.logger.info 'Finished scheduling categories to be updated by Sidekiq...'
  end

  ###
  #   Categories
  ###

  # Update Categories
  def self.update_categories_from_repos
    Rails.logger.info 'Processing Updater.update_categories_from_repos...'
    
    # Reset tag counts
    #   (if tag is completely removed categories would not be updated otherwise and remain visible)
    Category.all.each do |category|
      category.update_attribute(:repo_count, 0)
    end

    tags = Repo.tag_counts_on(:categories)
    tags.each do |tag| 
      if update_category_attributes(tag)
        # success
      else
        # error
        Rails.logger.error "Failed to update category '#{ tag.name }'"
      end
    end
    Rails.logger.info 'Finished processing Updater.update_categories_from_repos'
  end

protected


  ###
  #   Categories
  ###

  # Update a single category
  def self.update_category_attributes(tag)
    # Find or initialize category
    category = Category.find_or_initialize_by_name(tag[:name])

    # Popular Repos and All Repos (String)
    repos = Repo.tagged_with(tag[:name], on: :categories).order_knight_score

    # Popular Repos
    category[:popular_repos] = repos[0..2].inject('') do |result, repo|
      result = result.split(', ')
      result << repo[:full_name]
      result.join(', ')
    end
    # All Repos (excluding the ones already listed in popular_repos)
    if repos[3..repos.length].blank?
      category[:all_repos] = ""
    else
      category[:all_repos] = repos[3..repos.length].inject("") do |result, repo|
        result = result.split(", ")
        result << repo[:full_name]
        result.join(", ")
      end
    end

    # Repo Count
    category[:repo_count] = tag.count

    # Watcher Count
    # category[:watcher_count] = repos.sum(&:watchers)
    # Note: nil.to_i => 0
    category[:watcher_count] = repos.sum { |repo| repo.watchers.to_i }

    # Knight Score
    # category[:knight_score] = repos.sum(&:knight_score)
    category[:knight_score] = repos.sum { |repo| repo.knight_score.to_i }

    # Save category
    if category.save
      true
    else
      # e.g. Validation failed
      Rails.logger.error "Failed saving category '#{ category.name }'"
      false
    end
  end

end
