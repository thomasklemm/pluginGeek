class CategoryUpdater

  ###
  #
  #   CategoryUpdater
  #
  #   Instance Methods:
  #     - perform(tag_name, tag_count): Update a single category
  #
  #   Class Methods:
  #     - perform_async(tag_name, tag_count): Schedule a single category
  #         to be updated asynchronously by the Sidekiq process
  #     - update_categories_sidekiq: Trigger an asynchronous, 
  #         Sidekiq-powered update of all categories
  #     - update_categories_serial: Update all categories in serial,
  #         blocking the Thread in which it is called
  #
  ###

  # Include Sidekiq::Worker Module
  include Sidekiq::Worker

  # Update a single category
  def perform(tag_name, tag_count)
    # Find or initialize category
    category = Category.find_or_initialize_by_name(tag_name)

    # Popular Repos and All Repos (String)
    repos = Repo.has_category(tag_name)

    # Popular Repos
    category[:popular_repos] = repos[0..2].inject('') do |result, repo|
      result = result.split(', ')
      result << repo[:full_name]
      result.join(', ')
    end
    # All Repos (excluding the ones already listed in popular_repos)
    if repos[3..repos.length].blank?
      category[:all_repos] = ''
    else
      category[:all_repos] = repos[3..repos.length].inject('') do |result, repo|
        result = result.split(', ')
        result << repo[:full_name]
        result.join(', ')
      end
    end

    # Repo Count
    category[:repo_count] = tag_count

    # Watcher Count
    # category[:watcher_count] = repos.sum(&:watchers)
    # Note: nil.to_i => 0
    category[:watcher_count] = repos.sum { |repo| repo.watchers.to_i }

    # Knight Score
    # category[:knight_score] = repos.sum(&:knight_score)
    category[:knight_score] = repos.sum { |repo| repo.knight_score.to_i }

    # Save category
    if category.save
      Rails.logger.info "Updated category '#{ category.name }'"
      true
    else
      # e.g. Validation failed
      Rails.logger.error "Failed updating/saving category '#{ category.name }'"
      false
    end
  end

  # Update Categories Async
  def self.update_categories_sidekiq
    Rails.logger.info 'Scheduling updating each category using Sidekiq...'

    # Reset tag counts
    #  (if tag is completely removed categories would not be updated otherwise 
    #   and remain visible)
    Category.update_all(repo_count: 0)

    # Count tags
    tags = Repo.tag_counts_on(:categories)

    # Update each tag
    tags.each { |tag| perform_async(tag.name, tag.count) }
    Rails.logger.info 'Finished scheduling updating each category using Sidekiq...'
  end

  # Update Categories Sync
  def self.update_categories_serial
    Rails.logger.info 'Updating categories from repos in serial...'

    # CategoryUpdater Object
    category_updater = CategoryUpdater.new
    
    # Reset tag counts
    #  (if tag is completely removed categories would not be updated otherwise 
    #   and remain visible)
    Category.update_all(repo_count: 0)

    # Count tags
    tags = Repo.tag_counts_on(:categories)

    # Update each tag
    tags.each do |tag| 
      if category_updater.perform(tag.name, tag.count)
        # success
      else
        # error
        Rails.logger.error "Failed to update category '#{ tag.name }'"
      end
    end
    Rails.logger.info 'Finished updating categories from repos in serial'
  end

end