# application_bottom.js.coffee

# jQuery and jQuery UJS
#   insert jQuery-Tag before that (served via CDN)
//= require jquery_ujs
//= require jquery.timeago

# Foundation
//= require foundation/jquery.reveal
#//= require foundation/jquery.customforms
//= require foundation/jquery.placeholder.min
//= require foundation/jquery.tooltips
//= require foundation/foundation

# Readme, Autogrow & Select2
//= require readme
//= require jquery.autogrow
//= require select2

# Knight
//= require categories
//= require repos
//= require users


$ ->
  # Sort Buttons -> Mark sorted one as active
  $('.sort').click ->
      $(this).addClass('active')
      $(this).siblings('dd').removeClass('active')

  ###
  # Show all / all matching items in List.js
  ###
  list = categoriesList if categoriesList.listContainer?
  list = reposList if reposList.listContainer?
  p = list?.page
  button = $('.js_show_all_matching_items')

  # Initial
  m = list?.matchingItems.length
  if p < m
    button.show()

  evaluate_button = () ->
    m = list.matchingItems.length
    if p < m
      button.show()
    else
      button.hide()

  # On keyup in search input
  $('.search').keyup ->
    evaluate_button()
    $('abbr.timeago').timeago()


  # on click on 'show all matching repos / categories'
  button.click ->
    list.page = 2500
    list.update()
    button.hide()
    $('abbr.timeago').timeago()


  # Category Markdown Description Textarea Autogrow
  $('#category_md_description').autoGrow()

  # Search for Group instead of loading category
  # on click on category_group
  $('.category_group').live 'click', (e) ->
    $this = $(this)
    e.preventDefault()
    $('.search').val($this.text())
    list.search($this.text())
    $('.search').focus()
    evaluate_button()