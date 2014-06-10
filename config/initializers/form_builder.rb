class ActionView::Helpers::FormBuilder
  delegate :select, :options_for_select, to: :@template

  def category_picker(attribute, assignable_categories, options = {})
    category_picker_options =
      options_for_select(assignable_categories.map do |category|
        category = category.decorate
        [ category.name, category.id,
          { data: { data: category.to_selectize_option }
        }]
      end, @object.send(attribute))

    select @object_name, attribute, category_picker_options, {},
      options.reverse_merge({ multiple: true, class: 'category_picker' })
  end

  def repo_picker(attribute, assignable_repos, options = {})
    repo_picker_options =
      options_for_select(assignable_repos.map do |repo|
        repo = repo.decorate
        [ repo.owner_and_name, repo.id,
          { data: { data: repo.to_selectize_option }
        }]
      end, @object.send(attribute))

    select @object_name, attribute, repo_picker_options, {},
      options.reverse_merge({ multiple: true, class: 'repo_picker' })
  end

end
