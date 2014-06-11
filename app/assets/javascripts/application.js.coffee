# application.js.coffee
#
#= require jquery
#= require jquery_ujs
#= require local_time
#= require readme
#= require selectize
#= require theme
#= require category_picker
#= require repo_picker
#= require form

$ ->
  ##
  # Expand repo README's on click
  $('.readme__expander').click ->
    $this = $(this)
    $this.siblings('.readme__inner_container').removeClass('is_closed')
    $this.hide()
