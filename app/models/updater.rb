class Updater

  # Github Attribute Mapping
  GITHUB_REPO_ATTRIBUTES = Hash[full_name: 'full_name', name: 'name',
      description: 'description', watchers: 'watchers', forks: 'forks',
      github_url: 'html_url', homepage_url: 'homepage', owner: ['owner', 'login'], github_updated_at: 'pushed_at' ].freeze
  GITHUB_API_BASE_URL = 'https://api.github.com/'.freeze


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

  # Update repos
  def self.update_repos_from_github
    Rails.logger.info 'Processing Updater.update_repos_from_github...'
    conn = Excon.new(GITHUB_API_BASE_URL)
    # REVIEW: Rails API Docs suggest not using find_each for less than 1000 records
    # REVIEW: Do this concurrently, maybe by using Celluloid
    Repo.find_each(batch_size: 250) do |repo|
      if update_repo(repo, conn)
        # update finished success
      else
        # update threw error
        Rails.logger.error "Failed to update repo '#{ repo.full_name }'"
        # TODO: Mark repo for manual cleanup
        #   i.e. by using flag-shi-tzu (preferred)
        #   i.e. repo.update_attribute(:manual_work_required, true)
      end
    end
    Rails.logger.info 'Finished processing Updater.update_repos_from_github'
  end

  # Initialize (or manually update) repo
  def self.initialize_repo_from_github(repo_full_name)
    repo = Repo.find_or_initialize_by_full_name(repo_full_name)
    if update_repo(repo)
      # success
      true
    else
      # error
      false
      Rails.logger.warn "Failed to initialize repo '#{ repo.full_name }'"
    end
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
  #   Repos
  ###

  # Update a single repo
  def self.update_repo(repo, conn = Excon.new(GITHUB_API_BASE_URL))
    # Request
    path = '/repos/' + repo.full_name
    res = conn.get(path: path)

    # Exit on error
    res.status != 200 and return false

    # Success Handling
    github_repo = JSON.parse(res.body)

    # Update every attribute individually
    repo = recursive_update_of_repo_attributes(repo, github_repo)

    # Make homepage_url absolute
    #   will be relative e.g. for 'activeadmin.info'
    #   and assign the github_url to homepage_url if none is given
    if repo[:homepage_url].present?
      repo[:homepage_url] = "http://" + repo[:homepage_url] unless repo[:homepage_url].start_with?('http')
    else
      repo[:homepage_url] = repo[:github_url]
    end
    
    # Limit description length
    #  Honor Postgres string limit 255 characters
    repo[:description] &&= repo[:description].truncate(250)

    # Calculate Knight Score
    repo[:knight_score] = knight_score(github_repo)

    # Save Repo
    if repo.save
      # Validations fine
      true
    else
      # e.g. Validation errors
      Rails.logger.error "Failed saving repo '#{ repo.full_name }'"
      false
    end
  end

  # Update Repo Attributes recursively
  def self.recursive_update_of_repo_attributes(repo, github_repo)
    # Mapped attributes
    GITHUB_REPO_ATTRIBUTES.each do |repo_attr, github_attr|
      # Cast String to Array
      h = github_attr.kind_of?(String) ? github_attr.split : github_attr

      # Recursive lookup and assignment
      h.size.times do |index|
        repo[repo_attr] = index.zero? ? github_repo[h[index]] : repo[repo_attr][h[index]]
      end
    end

    # Return repo
    return repo
  end

  # Calculate Knight Score
  #   calculate knight score
  #   returns knight score as an integer
  def self.knight_score(github_repo)
    (github_repo['watchers'] * activity_score(github_repo['pushed_at'])).ceil
  end

  # Calculate Acitvity Score
  #   used as a multiplier when calculating a repo's knight score
  def self.activity_score(time)
    diff = Time.now - time.to_datetime
    score = case diff
            when 0..2.months                    then (2.0 - ( diff /  2.months * 0.4 ))
            when 2.months+1.second..6.months    then (1.6 - ( diff /  6.months * 0.4 ))
            when 6.months+1.second..12.months   then (1.2 - ( diff / 12.months * 0.3 ))
            when 12.months+1.second..18.months  then (0.9 - ( diff / 18.months * 0.2 ))
            when 18.months+1.second..24.months  then (0.7 - ( diff / 24.months * 0.2 ))
            when 24.months+1.second..36.months  then (0.5 - ( diff / 36.months * 0.2 ))
            else  0.3
            end
    score
  end

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
