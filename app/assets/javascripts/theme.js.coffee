$ ->
  ##
  # Flash messages / alerts
  #   Dismiss on click
  $('.alert').click ->
    $(this).fadeOut()

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
