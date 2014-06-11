@Form =
  init: ->
    @initCategoryPickers()
    @initRepoPickers()

  initCategoryPickers: ->
    $('.category_picker').each (index, element) ->
      new CategoryPicker(element)

  initRepoPickers: ->
    $('.repo_picker').each (index, element) ->
      new RepoPicker(element)
