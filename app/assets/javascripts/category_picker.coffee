class window.CategoryPicker
  constructor: (@selector) ->
    @selectize = null
    @initialize()
    @loadOptions()

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
      option: (item, escape) ->
        '<div>' +
        '<span class="name">' + escape(item.name) + '</span>' +
        '</div>'

  loadOptions: ->
    categories_path = '/categories/autocomplete.json'

    $.getJSON categories_path, (data) =>
      categories = data.categories

      @selectize.load (callback) ->
        callback(categories)

      @selectize.refreshOptions(false)
