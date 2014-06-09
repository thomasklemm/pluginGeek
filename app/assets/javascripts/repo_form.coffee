@RepoForm =
  init: ->
    @initCategoryPicker()

  initCategoryPicker: ->
    new CategoryPicker('#repo_category_ids')
