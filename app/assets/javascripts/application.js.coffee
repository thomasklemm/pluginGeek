# application.js.coffee
#
# Load jQuery from CDN beforehand
//= require list
//= require jquery_ujs
//= require jquery.timeago
//= require jquery.autosize
//= require readme
//= require select2
//= require peek
//= require 'peek/views/performance_bar'

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

  ##
  # List.js
  #
  # Variables for list.js
  $search = $('.js-search')         # Search field
  $show_button = $('.js-show-all')  # 'Display all items' button

  list = categoriesList if categoriesList.listContainer?
  list = reposList if reposList.listContainer?

  # Update list view
  # display or hide show button
  # and update relative timestamps on newly visible items
  update_list_view = () ->
    display_or_hide_show_button()
    update_timestamps()

  # Expand list
  # to display all items
  expand_list = () ->
    list.page = 3200
    list.update()
    update_list_view() # update timestamps and hide show_button

  # Decide if the show_button should be visible
  display_or_hide_show_button = () ->
    page = list?.page
    matches = list?.matchingItems.length
    if page && matches
      if page < matches
        $show_button.show()
      else
        $show_button.hide()
    else
      $show_button.hide()

  ##
  # List and search Initialization
  # Autofocus on search field
  $search.focus()
  update_list_view() # update visibility of show_button

  ##
  # List.js Events
  #
  # Expand list on click on 'display all matches'
  $show_button.click ->
    expand_list() # includes updating timestamps and hiding show_button

  # Person typing in search field
  $search.keyup ->
    update_list_view() # update timestamps and visibilty of show_button

  ##
  # List.js Sorting
  #
  # Click on sort button marks it as active and
  # removes active class from sibling further sort buttons
  $('.sort').click ->
    $(this).addClass('active').siblings('a').removeClass('active')
    update_list_view() # update timestamps

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
