module ApplicationHelper

  # A Greeting to all visiting Knights
  RUBY_NAMES = ['Ruby Warrior', 'Ruby Knight', 'Knight']
  def greeting_name
    case language
    when 'ruby' then RUBY_NAMES.sample
    else 'Knight'
    end
  end

end
