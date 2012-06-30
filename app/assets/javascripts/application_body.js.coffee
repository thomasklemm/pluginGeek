# application_bottom.js.coffee

# jQuery from CDN required in before that
//= require jquery_ujs

//= require categories
//= require repos
//= require users

$ ->
  # Alert Boxes
  $(".alert-box").delegate "a.close", "click", ->
    event.preventDefault()
    $(this).closest(".alert-box").fadeOut ->
      $(this).remove()


  # Current Sort Highlighting
  $('.sort').click ->
    $(this).addClass('sorted')
    $(this).siblings('.sort').removeClass('sorted')


  # Show all matching items in List.js
  list = categoriesList
  p = list.page
  button = $('.js_show_all_matching_items')

  # Initial
  m = list.matchingItems.length
  if p < m
    button.show()

  # On keyup in search input
  $('.search').keyup ->
    m = list.matchingItems.length
    if p < m
      button.show()
    else
      button.hide()

  # on click on 'show all matching repos / categories'
  button.click ->
    list.page = 2500
    list.update()
    button.hide()