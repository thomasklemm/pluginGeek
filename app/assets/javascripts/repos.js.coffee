# repos.js.coffee

$ ->

  # Toggle displaying of plugins
  $('.toggle_repo_children').live 'click', (event) ->
    $(this).siblings('.child').toggle()
    event.preventDefault()