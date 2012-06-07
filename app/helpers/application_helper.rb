module ApplicationHelper

  def title_helper
    # Repo
    title = 'Knight.io - Discover Rubygems'
    @repo and title = "#{ @repo.full_name} - Knight.io"
    @tag and title = "#{ @tag.name } - Knight.io"

    title
  end

  def flash_message_container(type)
    klass = 'alert-box'
    klass = 'alert-box success' if type == :notice
    klass = 'alert-box error' if type == :alert
    klass
  end

end
