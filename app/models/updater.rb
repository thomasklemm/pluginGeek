class Updater

  # Github Attribute Mapping
  GITHUB_REPO_ATTRIBUTES = Hash[full_name: 'full_name', name: 'name',
      description: 'description', watchers: 'watchers', forks: 'forks',
      github_url: 'html_url', homepage_url: 'homepage', owner: ['owner', 'login'], github_updated_at: 'pushed_at' ]
  GITHUB_API_BASE_URL = 'https://api.github.com/'


  ###
  #   Repos
  ###

  # Update repos
  #   by running 'Updater.update_repos_from_github'
  def self.update_repos_from_github
    conn = Excon.new(GITHUB_API_BASE_URL)
    # REVIEW: Rails API Doc suggests not using find_each for less than 1000 records
    Repo.find_each(batch_size: 200) do |repo|
      if update_repo(repo, conn)
        # success
      else
        # error
        # TODO: Mark repo for manual cleanup
        #   i.e. by using flag-shi-tzu (preferred)
        #   i.e. repo.update_attribute(:manual_work_required, true)
        puts "ERROR while updating '#{ repo.full_name }'."
      end
    end
    puts "'Updater.update_repos_from_github' successfully finished."
  end

  # Initialize (or manually update) repo
  #   by calling 'Updater.initialize_repo_from_github'
  def self.initialize_repo_from_github(repo_full_name)
    repo = Repo.find_or_initialize_by_full_name(repo_full_name)
    if update_repo(repo)
      # success
      true
    else
      # error
      false
    end
  end


  ###
  #   Categories
  ###

  # Update Categories
  #   by running 'Updater.update_categories_from_repos'
  def self.update_categories_from_repos
    # Reset tag counts (if tag is completely removed categories would not be updated)
    Category.all.each do |category|
      category.update_attribute(:repo_count, 0)
    end

    tags = Repo.tag_counts_on(:categories)
    tags.each { |tag| update_category_attributes(tag) }
  end

  ###
  #   Seeds
  ###

  # Rename a category
  #   Run 'Updater.rename_category(old_name, new_name)'
  def self.rename_category(old_name, new_name)
    puts "The following message should appear once for each affected model (2 right now)."
    models = [ActsAsTaggableOn::Tag, Category]
    models.each do |model|
      tag = model.find_by_name(old_name)
      tag.name = new_name
      if tag.save
        puts "Renamed category '#{ old_name }' to '#{ new_name } in model #{ model.to_s }'."
      else
        puts "ERROR while renaming category '#{ old_name }' to '#{ new_name }' in model #{ model.to_s }."
      end
    end
  end


  # transcribe seed format to a new one
  # def self.transcribe_seeds
  #   puts "The following messages should appear once for each affected model (currently two)."
  #   models = [ActsAsTaggableOn::Tag, Category]
  #   models.each do |model|
  #     model.all.each do |tag|
  #       match = /\((?<group>.*)\)(?<tag>.*)/.match(tag.name)
  #       if match
  #         group = match[:group].strip
  #         t = match[:tag].strip

  #         old_name = tag.name

  #         tag.name = "#{ t } (#{ group })"

  #         if tag.save
  #           puts "Category '#{ old_name}' renamed to '#{ tag.name }'."
  #         else
  #           puts "ERROR while renaming '#{ old_name}' to '#{ tag.name }'."
  #         end
  #       end
  #     end
  #   end
  # end

protected

  def self.update_repo(repo, conn = Excon.new(GITHUB_API_BASE_URL))
    # Request
    path = '/repos/' + repo.full_name
    res = conn.get(path: path)

    # Error Handling
    #   e.g. mark with flag for manual handling
    #   be sure to return in case of repo renamed or non-existent etc on github
    res.status != 200 and return false

    # Success Handling
    github_repo = JSON.parse(res.body)

    # Update every attribute individually
    repo = recursive_update_of_repo_attributes(repo, github_repo)

    # Remove Homepage if it is the same as github_url
    #   (does not work if https:// is substituted with http://)
    repo[:homepage_url] = nil if repo[:homepage_url] == repo[:github_url]

    # Limit description length
    #   REVIEW: Better way to handle this? Postgres will throw errors is length exceeds 255 characters
    repo[:description] = repo[:description].truncate(220) if repo[:description]

    # Calculate Knight Score
    repo[:knight_score] = knight_score(github_repo)
    # Save Repo
    repo.save
  end

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

  # Knight Score
  #   calculate knight score
  #   returns knight score as an integer
  def self.knight_score(github_repo)
    (github_repo['watchers'] * activity_score(github_repo['pushed_at'])).ceil
  end

  # Acitvity Score
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
    category[:watcher_count] = repos.sum(&:watchers)
    #   Alternative: category[:watcher_count] = repos.sum { |repo| repo.watchers }

    # Knight Score
    category[:knight_score] = repos.sum(&:knight_score)

    # Save category
    category.save
  end

end
