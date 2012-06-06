module ApplicationHelper

  def title_helper
    # Repo
    title = 'Knight.io - Discover Rubygems'
    @repo and title = "#{ @repo.full_name} - Knight.io"
    @tag and title = "#{ @tag.name } - Knight.io"

    title
  end

  def flash_class(type)
    'alert-box'
    'alert-box success' if type == 'notice'
    'alert-box error' if type == 'alert'
  end

end
