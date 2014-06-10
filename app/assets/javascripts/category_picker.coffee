class window.CategoryPicker
  constructor: (@selector) ->
    @selectize = null
    @initialize()
#    @loadOptions()

  initialize: ->
    $select = $(@selector).selectize @selectizeOptions()
    @selectize = $select[0].selectize

  selectizeOptions: ->
    valueField: 'id'
    labelField: 'name'
    searchField: ['name', 'repo_names']
    sortField:
      field: 'score'
      direction: 'desc'
    create: false
    render:
      item: (item, escape) ->
        '<div class="category">' +
        '<span class="name">' + escape(item.name) + '</span>' +
        '<span class="platform_names">' + '(' + escape(item.platform_names) + ')' + '</span>' +
        '</div>'
      option: (item, escape) ->
        '<div class="category">' +
        '<span class="name">' + escape(item.name) + '</span>' +
        '<span class="platform_names">' + '(' + escape(item.platform_names) + ')' + '</span>' +
        '<div class="meta">' +
        '<span class="stars">' + '<i class="icon fa fa-star"></i>' + escape(item.formatted_stars) + '</span>' +
        '<span class="repos_count">' + '<i class="icon fa fa-github-alt"></i>' + escape(item.repos_count) + '</span>' +
        '</div>' +
        '<span class="repo_names">' + 'Includes ' + escape(item.short_formatted_repo_names) + '</span>' +
        '</div>'

#  loadOptions: ->
#    categories_path = '/categories/autocomplete.json'
#
#    $.getJSON categories_path, (data) =>
#      categories = data.categories
#
#      @selectize.load (callback) ->
#        callback(categories)
#
#      @selectize.refreshOptions(false)
