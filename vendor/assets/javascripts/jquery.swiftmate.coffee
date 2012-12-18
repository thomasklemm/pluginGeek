$ = jQuery

class Query
  constructor: (@minLength) ->
    @value = ''
    @lastValue = ''

  getValue: ->
    @value

  setValue: (newValue) ->
    @lastValue = @value
    @value = newValue

  hasChanged: ->
    !(@value == @lastValue)

  willHaveResults: ->
    @_isValid()

  _isValid: ->
    @value.length >= @minLength

class Suggestion
  constructor: (index, @data, @type) ->
    @id = "#{index}-swiftmate-suggestion"
    @index = index

  select: (callback) ->
    callback( @data, @type, @index, @id)

  focus: ->
    @element().addClass( 'focus' )

  blur: ->
    @element().removeClass( 'focus' )

  render: (callback) ->
    """
      <li id="#{@id}" class="swiftmate-suggestion">
        #{callback( @data, @type, @index, @id)}
      </li>
    """

  element: ->
    $('#' + @id)

class SuggestionCollection
  constructor: (@renderCallback, @selectCallback) ->
    @focusedIndex = -1
    @suggestions = []

  update: (results) ->
    @suggestions = []
    i = 0

    for type, typeResults of results
      for result in typeResults
        @suggestions.push( new Suggestion(i, result, type) )
        i += 1

  blurAll: ->
    @focusedIndex = -1
    suggestion.blur() for suggestion in @suggestions

  render: ->
    h = ''

    if @suggestions.length

      type = null

      for suggestion in @suggestions

        if suggestion.type != type

          h += @_renderTypeEnd( type ) unless type == null
          type = suggestion.type
          h += @_renderTypeStart()

        h += @_renderSuggestion( suggestion )

      h += @_renderTypeEnd( type )

    return h

  count: ->
    @suggestions.length

  focus: (i) ->
    if i < @count()
      @blurAll()

      if i < 0
        @focusedIndex = -1

      else
        @suggestions[i].focus()
        @focusedIndex = i

  focusElement: (element) ->
    index = parseInt( $(element).attr('id') )
    @focus( index )

  focusNext: ->
    @focus( @focusedIndex + 1 )

  focusPrevious: ->
    @focus( @focusedIndex - 1 )

  selectFocused: ->
    if @focusedIndex >= 0
      @suggestions[@focusedIndex].select( @selectCallback )

  allBlured: ->
    @focusedIndex == -1

  # PRIVATE

  _renderTypeStart: ->
    """
      <li class="swiftmate-type-container">
        <ul class="swiftmate-type-suggestions">
    """

  _renderTypeEnd: (type) ->
    """
        </ul>
        <div class="swiftmate-type">#{type}</div>
      </li>
    """

  _renderSuggestion: (suggestion) ->
    suggestion.render( @renderCallback )


class Swiftmate

  KEYCODES = {9: 'tab', 13: 'enter', 27: 'escape', 38: 'up', 40: 'down'}

  constructor: (@input, options) ->

    that = this

    {url, engineKey, documentTypes, filters, searchFields, functionalBoosts, sortField, sortDirection,
      fetchFields, facets, maxResults, renderCallback, selectCallback, minQueryLength, timeout} = options

    @url              = url || 'https://api.swiftype.com/api/v1/public/engines/suggest'
    @engineKey        = engineKey
    @types            = documentTypes
    @filters          = filters
    @searchFields     = searchFields
    @functionalBoosts = functionalBoosts
    @sortField        = sortField
    @sortDirection    = sortDirection
    @fetchFields      = fetchFields
    @facets           = facets
    @maxResults       = maxResults || 5
    @timeout          = timeout || 1000

    @xhr              = null

    # Follow url by default
    selectCallback    = selectCallback || @_defaultSelectCallback
    minQueryLength    = minQueryLength || 2

    @suggestions      = new SuggestionCollection( renderCallback, selectCallback )
    @query            = new Query( minQueryLength )

    if ($('ul#swiftmate').length > 0)
      @container = $('ul#swiftmate')
    else
      @container = $('<ul id="swiftmate">').insertAfter(@input)
    @container.delegate('.swiftmate-suggestion',
      mouseover: -> that.suggestions.focusElement( this )
      click: (event) ->
        event.preventDefault()
        that.suggestions.selectFocused()

        # Refocus the input field so it remains active after clicking a suggestion.
        that.input.focus()
    )

    @input.
      keydown( @handleKeydown ).
      keyup( @handleKeyup ).
      mouseover( ->
        that.suggestions.blurAll()
      )

  handleKeydown: (event) =>
    killEvent = true

    switch KEYCODES[event.keyCode]

      when 'escape'
        @hideContainer()

      when 'tab'
        @suggestions.selectFocused()

      when 'enter'
        @suggestions.selectFocused()
        # Submit the form if no input is focused.
        if @suggestions.allBlured()
          killEvent = false

      when 'up'
        @suggestions.focusPrevious()

      when 'down'
        @suggestions.focusNext()

      else
        killEvent = false

    if killEvent
      event.stopImmediatePropagation()
      event.preventDefault()

  handleKeyup: (event) =>
    @query.setValue( @input.val() )

    if @query.hasChanged()

      if @query.willHaveResults()

        @suggestions.blurAll()
        @fetchResults()

      else
        @hideContainer()

  hideContainer: ->
    @suggestions.blurAll()

    @container.hide()

    # Stop capturing any document click events.
    $(document).unbind('click.swiftmate')

  showContainer: ->
    @container.show()

    # Hide the container if the user clicks outside of it.
    $(document).bind('click.swiftmate', (event) =>
      @hideContainer() unless @container.has( $(event.target) ).length
    )

  fetchResults: ->
    # Cancel any previous requests if there are any.
    @xhr.abort() if @xhr?

    @xhr = $.ajax({
      url: @url
      dataType: 'jsonp'
      timeout: @timeout
      cache: true
      data: {
        q: @query.getValue()
        engine_key: @engineKey
        filters: @filters
        search_fields: @searchFields
        functional_boosts: @functionalBoosts
        fetch_fields: @fetchFields
        sort_field: @sortField
        sort_direction: @sortDirection
        facets: @facets
        per_page: @maxResults
      }
      success: (data) =>
        @update( data.records )
    })

  update: (results) ->
    @suggestions.update(results)

    if @suggestions.count() > 0
      @container.html( $(@suggestions.render()) )
      @showContainer()

    else
      @hideContainer()

  # PRIVATE

  _defaultSelectCallback: (data) ->
    window.location = data.url

$.fn.swiftmate = (options) ->
  new Swiftmate($(this), options)
  return $(this)

# window._test = {
#   Query: Query
#   Suggestion: Suggestion
#   SuggestionCollection: SuggestionCollection
#   Swiftmate: Swiftmate
# }
