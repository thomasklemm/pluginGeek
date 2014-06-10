class window.RepoPicker
  constructor: (@selector) ->
    @selectize = null
    @initialize()

  initialize: ->
    $select = $(@selector).selectize @selectizeOptions()
    @selectize = $select[0].selectize

  selectizeOptions: ->
    create: false
