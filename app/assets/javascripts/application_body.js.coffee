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
  # Category Markdown Description Textarea Autogrow
  $('#category_description').autoGrow()

  # Update Timeago
  # for previously hidden items
  update_timeago = () ->
    $('abbr.timeago').timeago()

  ###
  #   Search Field
  #   make search field clearable
  ###
  $search_field = $('.search')

  # Clearable Plugin
  `;(function ($, undefined) {
    $.fn.clearable = function () {
        /* Initialize elements */
        var $this = this
        $this.wrap('<div class="clear_container" />');
        var container = $this.parent();
        var helper = $('<span class="clear_helper"></span>');
        var icon = $('<i class="js_clear_icon clear_icon icon-remove"></i>');

        /* Append elements and hide icon by default */
        container.append(helper);
        helper.append(icon);
        icon.hide();

        /* Clear search field on click on icon */
        icon
          .attr('title', 'Click to clear this search')
          .click(function(){
            /* Clear value and focus search field */
            $this.val('').focus();

            /* Update list.js */
            list.search();

            /* Evaluate visibility of icon and show all button */
            update_view();
          });
    };
  })(jQuery);`

  # Initialize clearable search field
  $search_field.clearable()

  ###
  #   List.js
  #   Show all / all matching items in List.js
  ###
  list = categoriesList if categoriesList.listContainer?
  list = reposList if reposList.listContainer?
  p = list?.page
  $button = $('.js_show_all_matching_items')

  # Initial
  m = list?.matchingItems.length
  if p < m
    $button.show()

  # on click on 'show all matching repos / categories'
  $button.click ->
    list.page = 2500
    list.update()
    # update button visibility and timestamps
    update_view()

  # On keyup in search input
  $search_field.keyup () ->
    update_view()

  # Decide if show all button should be visible
  eval_show_all_button = () ->
    p = list?.page
    m = list.matchingItems.length
    if p < m
      $button.show()
    else
      $button.hide()

  # Decide if clear icon should be visible
  $clear_icon = $('.js_clear_icon')
  eval_clear_icon = () ->
    if $search_field.val() is ''
      $clear_icon.hide()
    else
      $clear_icon.show()

  # Update View
  update_view = () ->
    eval_show_all_button()
    eval_clear_icon()
    update_timeago()
  # Update view on initialize mainly to hide clear icon
  update_view()

  # Search for Group instead of loading category
  # on click on js_category_group
  $('.category_group').live 'click', (e) ->
    $this = $(this)
    e.preventDefault()
    # Insert value in field
    $search_field.val($this.text()).focus()
    # Search list for value
    list.search($this.text())
    # Update view
    # update_view()

  # Search Field Autofocus
  # Somehow HTML5 attribute won't work with current setup
  $search_field.focus()

  # Sort Buttons -> Mark sorted one as active
  $('.sort').click ->
      $this = $(this)
      $this.addClass('active')
      $this.siblings('dd').removeClass('active')
