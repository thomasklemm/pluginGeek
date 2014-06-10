class ActionView::Helpers::FormBuilder
  delegate :select, :options_for_select, to: :@template

  def category_picker(attribute)
    category_picker_options =
      options_for_select(@object.assignable_categories.map do |category|
        category = category.decorate
        [ category.name, category.id, { data: { data: category.to_selectize_option } } ]
      end, @object.category_ids)

    select @object_name, attribute, category_picker_options, {}, { multiple: true, class: 'category_picker' }
  end

end
