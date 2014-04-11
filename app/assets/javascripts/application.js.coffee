# application.js.coffee
#
#= require jquery
#= require jquery_ujs
#= require local_time
#= require readme

# Plugingeek
$ ->
  ##
  # Readme.js
  #
  # Unfold readme on user input
  $readme = $('.readme-target')
  $toggle_readme = $('.toggle-readme')

  $toggle_readme.click ->
    height = $readme.removeClass('max-height').addClass('auto-height').height()
    $readme.removeClass('auto-height').addClass('max-height')
    $readme.animate({ height: height }, 350)
    $(this).hide()

  ##
  # Alerts / Flash messages
  # Close on click
  $('.alert').click ->
    $(this).hide()
