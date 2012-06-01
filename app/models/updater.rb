class Updater

  # Github Attribute Mapping
  GITHUB_ATTRIBUTES = Hash[:full_name => "full_name", :name => "name",
      :description => "description", :watchers => "watchers", :forks => "forks",
      :github_url => "html_url", :homepage_url => "homepage", :owner => ["owner", "login"] ]
  GITHUB_API_BASE_URL = "https://api.github.com/"


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
        # repo.update_attribute(:manual_work_required, true)
      end
    end
    puts "'Updater.update_repos_from_github' successfully finished."
  end

  # Initialize (or manually update) repo
  #   by calling 'Updater.initialize_repo_from_github'
  def self.initialize_repo_from_github(repo_full_name)
    repo = Repo.find_by_full_name(repo_full_name)
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
  def update_categories_from_repos
    tags = Repo.tag_counts_on(:categories)
    tags.each { |tag| update_category_attributes(tag) }
  end


protected

  # Why has this to be a class method of Updater class (Won't work otherwise)?
  def self.update_repo(repo, conn = Excon.new(GITHUB_API_BASE_URL))
    # Request
    path = '/repos/' + repo.full_name
    res = conn.get(path: path)

    # Error Handling
    #   e.g. mark with flag for manual handling
    #   be sure to return in case of repo renamed or non-existent etc on github
    res.status != 200 and return puts 'Updating #{repo.full_name} failed.'

    # Success Handling
    github_repo = JSON.parse(res.body)

    # Update every attribute individually
    repo = recursive_update_of_repo_attributes(repo, github_repo)

    # Save Repo
    repo.save
  end

  # Same question: Why has this to be a class method of Updater class (Won't work otherwise)?
  def self.recursive_update_of_repo_attributes(repo, github_repo)
    # Mapped attributes
    GITHUB_ATTRIBUTES.each do |repo_attr, github_attr|
      # Cast String to Array
      github_attr.kind_of?(String) ? h = github_attr.split : h = github_attr

      # Recursive lookup and assignment
      h.length.times do |index|
        index.zero? ? repo[repo_attr] = github_repo[h[index]] : repo[repo_attr] = repo[repo_attr][h[index]]
      end
    end

    # Return repo
    return repo
  end

  def update_category_attributes(tag)
    # Find or initialize category
    category = self.find_or_initialize_by_name(tag.name)

    # Popular Repos and All Repos (String)
    repos = Repo.tagged_with(tag)

    # Popular Repos
    category[:popular_repos] = repos[0..2].inject { |string, repo| string + ", " + repo.full_name }
    # All Repos (excluding the ones already listed in popular_repos)
    category[:all_repos] = repos[3..repos.length].inject { |string, repo| string + ", " + repo.full_name }

    # Repo Count
    category[:repo_count] = tag.count
    # Watcher Count
    # Alternative: category[:watcher_count] = repos.sum { |repo| repo.watchers }
    category[:watcher_count] = repos.sum(&:watchers)

    # Save category
    category.save
  end

  # TODO: Read up about method scoping (public / private / protected). What should be used here?
  # TODO: Does passing the whole repo object around make sense?

end
