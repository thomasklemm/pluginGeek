module ApplicationHelper

  # A Greeting to all visiting Knights
  RUBY_NAMES = ['Ruby Warrior', 'Ruby Knight', 'Knight']
  def greeting_name
    case language
    when 'ruby' then RUBY_NAMES.sample
    else 'Knight'
    end
  end

  def stars_mixin(count)
    "<span class='stars'><i class='icon-star'></i>&nbsp;#{ count }</span>".html_safe
  end

  def language_size(size)
    (size/10*10).to_i
  end

end
