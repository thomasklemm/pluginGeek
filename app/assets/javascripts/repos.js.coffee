# repos.js.coffee

$ ->

  # Toggle displaying of plugins
  $('.plugins_button').live 'click', ->
    $(this).siblings('.child').toggle()