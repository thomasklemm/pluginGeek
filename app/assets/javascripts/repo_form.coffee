@RepoForm =
  init: ->
    @initCategoryPicker()

  initCategoryPicker: ->
    $('.category_picker').each (index, element) ->
      new CategoryPicker(element)
