module ApplicationHelper

  def title_helper
    # Repo
    title = "Knight.io - Github's finest Ruby Gems"
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

  # Determine which navitem is currently active and marking it with class active
  def active_subdomain(s)
    'active' if s.to_s == request.subdomain
  end

  # Determines which path is active and marks it with class active
  def active_path(path)
    p = request.path

    if p == '/categories' || p == '/'
      'active' if path == :categories
    elsif p == '/repos'
      'active' if path == :repos
    end

  end

end
