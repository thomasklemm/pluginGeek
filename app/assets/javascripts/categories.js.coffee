# categories.js.coffee

$ ->
  $('.sort').click ->
    $(this).addClass('sorted')
    $(this).siblings('.sort').removeClass('sorted')

###
$ ->
  $(".search").focus()

  tag_options =
    valueNames: ['name', 'description', 'repo_count', 'watcher_count', 'popular_repos', 'all_repos']

  tag_list = new List('js_tag_list', tag_options)

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


  $(".tag_header .edit").click (event) ->
    event.preventDefault()
###