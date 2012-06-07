module CategoriesHelper

  # category name and group helper
  #   wrap category name and category group in respective tags
  def category_name_helper(name)
    if index = name.index(')')
      name.insert(index + 1, '</span>').insert(0, '<span class="group">')
    else
      name
    end
  end

  # Popular Repos Helper
  #   wrap owner and name of each popular repo in respective tags
  def category_popular_repos_helper(repos)
    h = []
    repos.split(", ").each do |repo|
      owner = repo.split('/')[0]
      name = repo.split('/')[1]
      h << "<span class='owner'>#{ owner }/</span><span class='name'>#{ name }</span>"
    end
    h.join(', ')
  end

end
