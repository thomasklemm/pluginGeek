# application.js.coffee
# insert after jQuery
#
# Requires
//= require list
# jQuery Rails adapter
//= require jquery_ujs
//= require jquery.timeago
//= require jquery.trunk8
# //= require jquery.swiftmate
//= require readme
//= require select2

##
# Knight
$ ->
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
    $(this).addClass('active').siblings('li').removeClass('active')
    update_list_view() # update timestamps

  ##
  # Truncation via trunk8
  #
  # Truncate Repo Descriptions
  $('.repo .js-description').trunk8(
    fill: '&hellip; <a class="js-read-more">read more</a>'
  )

  # Display entire description on click on 'read more'
  $('.js-read-more').live 'click', (event) ->
    $(this).parent().trunk8('revert')
    return false

  # Truncate category descriptions
  # Note: Only trucates when category is being displayed among the first visible ones!
  $('.category .description').trunk8(
    fill: '&hellip; <a class="js-read-more">read more</a>'
    lines: 3
  )

  ##
  # Readme.js
  #
  # Unfold and fold Readme on user inputs
  # could certainly be shortened e.g. by using some kind of toggling
  $readme = $('.readme')

  open_readme = () ->
    $readme.removeClass('readme-max-height').addClass('readme-auto-height')

  close_readme = () ->
    $readme.removeClass('readme-auto-height').addClass('readme-max-height')

  $('.open-readme').live 'click', () ->
    $(this).removeClass('open-readme').addClass('close-readme').text('Fold Readme')
    open_readme()

  $('.close-readme').live 'click', () ->
    $(this).removeClass('close-readme').addClass('open-readme').text('Unfold Readme')
    close_readme()
