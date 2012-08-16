module ApplicationHelper

  # Flash Messages Container Classes
  def flash_message_container(type)
    klass = case type
            when :notice  then 'alert-box secondary'
            when :success then 'alert-box secondary'
            when :alert   then 'alert-box secondary'
            when :error   then 'alert-box secondary'
            else 'alert-box secondary'
            end
  end

  # A Greeting to all visiting Knights
  RUBY_NAMES = ['Ruby Warrior', 'Ruby Knight', 'Knight']
  def greeting_name
    case language
    when 'ruby' then RUBY_NAMES.sample
    else 'Knight'
    end
  end

end
