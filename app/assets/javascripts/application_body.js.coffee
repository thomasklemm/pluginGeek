# application_bottom.js.coffee

# jQuery from CDN required in before that
//= require jquery_ujs

//= require categories
//= require repos
//= require users

# Alert Boxes
$ ->
  $(".alert-box").delegate "a.close", "click", ->
    event.preventDefault()
    $(this).closest(".alert-box").fadeOut ->
      $(this).remove()


# Current Sort Highlighting
$ ->
  $('.sort').click ->
    $(this).addClass('sorted')
    $(this).siblings('.sort').removeClass('sorted')


