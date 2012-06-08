# categories.js.coffee


###
$ ->
  $(".search").focus()

  $(".reset").click  ->
    $(this).parent().siblings(".search").val("")
    tag_list.search()
    tag_list.sort('watcher_count', {asc: false})
    $(this).siblings(".sort").removeClass("active")
    $(this).siblings(".initial_sort").addClass("active")
    $(this).parent().siblings(".search").focus()

  $(".tag_header .edit").click (event) ->
    event.preventDefault()
###