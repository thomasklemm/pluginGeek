module FormHelper

  def help(text = nil, &block)
    text ||= capture(&block)
    content_tag(:div, text, class: 'help')
  end

  def required_field
    content_tag(:span, '*', title: 'Required field', class: 'required_field')
  end

end
