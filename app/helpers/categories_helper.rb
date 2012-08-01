module CategoriesHelper

  # category name and group helper
  #   wrap category name and category group in respective tags
  def category_name_helper(name_and_lang)
    match = /(?<group>.*)\:(?<name>.*)\((?<lang>.*)\)/.match(name_and_lang)

    if match
      # return name and group, strip lang
      group = match[:group].squish
      name = match[:name].squish
      "<span class='category_group'>#{ group }:</span> <span class='category_name'>#{ name }</span>"
    else
      match = /(?<name>.*)\((?<lang>.*)\)/.match(name_and_lang)

      if match
        # strip lang, return only name
        name = match[:name].squish
        "<span class='category_group'></span><span class='category_name'>#{ name }</span>"
      else
        # return input
        "<span class='category_group'></span><span class='category_name'>#{ name_and_lang }</span>"
      end
    end
  end

  # Popular Repos Helper
  #   wrap owner and name of each popular repo in respective tags
  def category_popular_repos_helper(repos)
    h = []
    # if there are repos split them etc.
    repos && repos.split(', ').each do |repo|
      owner = repo.split('/')[0]
      name = repo.split('/')[1]
      h << "<span class='repo_name'>#{ name }</span>"
    end
    h.join(', ')
  end

end
