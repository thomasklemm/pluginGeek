@RepoForm =
  init: ->
    @initCategoryPicker()
    @initRepoPicker()

  initCategoryPicker: ->
    $('.category_picker').each (index, element) ->
      new CategoryPicker(element)

  initRepoPicker: ->
    $('.repo_picker').each (index, element) ->
      new RepoPicker(element)
