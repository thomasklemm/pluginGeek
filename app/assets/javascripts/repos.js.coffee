# repos.js.coffee

$ ->

  # Toggle displaying of children / plugins
  $('.js_toggle_children').live 'click', (e) ->
    $(this).parent().siblings('.js_child_list').toggle()
    e.preventDefault()