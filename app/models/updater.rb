class Updater

  ###
  #   Repos
  ###

  def update_repos_from_github

  end

  ###
  #   Categories
  ###

  def update_categories_from_repos
    tags = Repo.tag_counts_on(:categories)
    tags.each { |tag| update_category_attributes(tag) }
  end

private

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
    category[:watcher_count] = repos.sum(&:watchers)
    # category[:watcher_count] = repos.sum { |repo| repo.watchers }

    # Save category
    category.save
  end


  # TODO: Read up about method scoping (public / private / protected). What should be used here?

end
