module CategoriesHelper

  # category name and group helper
  #   wrap category name and category group in respective tags
  def category_name_helper(name_and_lang)
    match = /(?<name>.*)\((?<lang>.*)\)/.match(name_and_lang)

    if match
      name = match[:name].squish
      lang = match[:lang].squish
      # if request has a subdomain then lang should not be displayed
      if request.subdomain.present?
        "<span class='name'>#{ name }</span><span class='lang'></span>"
      else
        "<span class='name'>#{ name }</span><span class='lang'>(#{ lang })</span>"
      end
    else
      "<span class='name'>#{ name_and_lang }</span><span class='lang'></span>"
    end
  end

  # Popular Repos Helper
  #   wrap owner and name of each popular repo in respective tags
  def category_popular_repos_helper(repos)
    h = []
    repos.split(', ').each do |repo|
      owner = repo.split('/')[0]
      name = repo.split('/')[1]
      h << "<span class='repo_owner'>#{ owner }/</span><span class='repo_name'>#{ name }</span>"
    end
    h.join(', ')
  end

end
