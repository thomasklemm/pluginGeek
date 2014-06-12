module FormHelper

  def form_actions(&block)
    content_tag :div, capture(&block), class: 'actions'
  end

  def form_checkbox(type = nil, &block)
    classes = %w(checkbox)
    classes << 'is_inline' if type == :inline
    content_tag :div, capture(&block), class: classes.join(' ')
  end

  def form_field(&block)
    content_tag :div, capture(&block), class: 'field'
  end

  def form_help(text = nil, &block)
    text ||= capture(&block)
    content_tag(:div, text, class: 'help')
  end

  def required_field
    content_tag(:span, '*', title: 'Required field', class: 'required_field')
  end

end
