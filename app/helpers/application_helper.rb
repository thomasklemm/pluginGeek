module ApplicationHelper

  # HTML Title
  def title_helper
    # Repo
    title = "Knight.io - Github's finest Ruby Gems"
    @repo and title = "#{ @repo.full_name} - Knight.io"
    @tag and title = "#{ @tag.name } - Knight.io"

    title
  end

  # Flash Messages Container Classes
  def flash_message_container(type)
    klass = 'alert-box'
    klass = 'alert-box'         if type == :notice
    klass = 'alert-box success' if type == :success
    klass = 'alert-box'         if type == :alert
    klass = 'alert-box alert'   if type == :error
    klass
  end

  # greeting every visiting knight
  # with a cool name
  RUBY_NAMES = ['Ruby Warrior', 'Ruby Knight', 'Knight']
  def greeting_name
    case language
    when 'ruby'
      RUBY_NAMES.sample
    else
      'Knight'
    end
  end

end
