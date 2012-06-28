# repos.js.coffee


###
$ ->
  $(".reset").click  ->
    $(this).parent().siblings(".search").val("")
    tag_list.search()
    tag_list.sort('watcher_count', {asc: false})
    $(this).siblings(".sort").removeClass("active")
    $(this).siblings(".initial_sort").addClass("active")
    $(this).parent().siblings(".search").focus()

  $(".sort").click ->
    $(this).addClass("active")
    $(this).siblings(".sort").removeClass("active")


  repo_options = ['full_name', 'watchers', 'description']

  repo_list = new List('js_repo_list', repo_options)
###

$ ->


  list = reposList || categoriesList
  p = list.page
  button = $('.js_show_all_matching_items')

  # Initial
  m = list.matchingItems.length
  if p < m
    button.show()

  # On keyup in search input
  $('.search').keyup ->
    m = list.matchingItems.length
    if p < m
      button.show()
    else
      button.hide()

  # on click on 'show all matching repos / categories'
  button.click ->
    list.page = 2500
    list.update()
    button.hide()