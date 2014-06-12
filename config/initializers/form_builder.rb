class ActionView::Helpers::FormBuilder
  delegate :select, :options_for_select, :content_tag,
    to: :@template

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
        [ repo.owner_and_name, repo.id ]
      end, @object.send(attribute))

    select @object_name, attribute, repo_picker_options, {},
      options.reverse_merge({ multiple: true, class: 'repo_picker' })
  end

  def error_message_on(attribute)
    messages = @object.errors[attribute]
    full_messages = []

    messages.each_with_index do |message, index|
      full_message = if message =~ /^\^/
        message.gsub(/^\^/, '')
      else
        @object.errors.full_messages_for(attribute)[index]
      end

      full_messages << content_tag(:div, full_message, class: 'error_message')
    end

    full_messages.join.html_safe
  end

end
