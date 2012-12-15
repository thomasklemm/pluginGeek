# application.js.coffee
# insert after jQuery

##
# Requires
# List.js
//= require list

# jQuery Rails adapter
//= require jquery_ujs
#= require foundation

# Foundation
//= require foundation

# Further libraries
//= require jquery.timeago
//= require jquery.autogrow
//= require jquery.swiftmate

//= require readme
//= require select2

##
# Knight
$ ->
  ##
  # Variables
  # Search field
  $search = $('.search')
  # 'Show all matching items' button for list.js
  $show_button = $('.js_show_all_matching_items')

  ##
  # List.js
  list = categoriesList if categoriesList.listContainer?
  list = reposList if reposList.listContainer?
  p = list?.page

  # Initial state
  m = list?.matchingItems.length
  if p < m
    $show_button.show()

  ##
  # Functions
  # Update relative timestamps
  update_timestamps = () ->
    # Timestamps
    $timestamps = $('abbr.timeago')
    $timestamps.timeago()

  # Decide if show all show_button should be visible
  visibility_of_show_button = () ->
    p = list?.page
    m = list?.matchingItems.length
    if p && m
      if p < m
        $show_button.show()
      else
        $show_button.hide()

  # Show no items found message of there are no matches
  visiblity_of_no_items_found_message = () ->
    m = list?.matchingItems.length
    if m
      if m == 0
        $('.list').html("<div class='no_matching_items'>Sorry. No matches. :-/<br/>Just try again. :-D</div>")

  # Update View
  update_view = () ->
    # Show or hide 'show all' button
    visibility_of_show_button()
    # Update timestamps of previously hidden fields
    update_timestamps()

  ##
  # Initialization
  # Autofocus on search field
  $search.focus()

  # Category Markdown Description Textarea Autogrow
  $('.autogrow').autoGrow()

  # Update view to calculate visibility of 'show more' button and more
  update_view()

  ##
  # Event handlers
  # Show all matching items
  # on click on 'show all' button
  $show_button.click ->
    list.page = 2500
    list.update()
    update_view()

  # Update timestamps and visibility of buttons
  # when typing in search field
  $search.keyup () ->
    update_view()
    # Display 'no results found' message if appropriate
    visiblity_of_no_items_found_message()

  # Click on sort button marks it as active and
  # removes active class from sibling further sort buttons
  $('.sort').click ->
    $this = $(this)
    $this.addClass('active')
    $this.siblings('li').removeClass('active')
    update_view()

  # Click on toggle children
  # toggles the child list of a repo
  $('.toggle_children').live 'click', (e) ->
    $(this).parent().siblings('.child_list').toggle()
    e.preventDefault()
