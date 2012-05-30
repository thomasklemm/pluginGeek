$ ->
  options =
    valueNames: ['name', 'description', 'repo_count', 'watcher_count', 'popular_repos', 'all_repos']

  tag_list = new List('js_tag_list', options)

  $(".reset").click  ->
    tag_list.filter()