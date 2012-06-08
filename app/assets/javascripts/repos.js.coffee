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