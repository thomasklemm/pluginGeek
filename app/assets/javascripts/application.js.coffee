# application.js.coffee
#
# Load jQuery from CDN beforehand
#= require jquery_ujs
#= require jquery.timeago
#= require jquery.autosize
#= require readme
#= require select2

# Plugingeek
$ ->
  ##
  # Autosize
  $('textarea').autosize()

  ##
  # Timeago
  # Update relative timestamps
  update_timestamps = () ->
    $timestamps = $('abbr.timeago')
    $timestamps.timeago()
  update_timestamps()

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
  # Flash messages
  # Close on click
  $('.flash-message .close').click ->
    $(this).parent().fadeOut()

  $('.flash-message').click ->
    $(this).fadeOut()
