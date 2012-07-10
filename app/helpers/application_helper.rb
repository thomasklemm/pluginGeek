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

  ###
  #   Navigation
  ###

  # # Active Language
  # def active_language(language)
  #   'active' if params[:language] == language.to_s
  # end

  # # Active Scope
  # def active_scope(scope)
  #   params[:scope] = 'categories' if params[:scope].blank?
  #   'active' if params[:scope] == scope.to_s
  # end

  # Active Navitem
  def active_navitem(language, scope)
    params[:scope] = 'categories' if params[:scope].blank?
    'active' if (params[:language] == language.to_s && params[:scope] == scope.to_s)
  end

  def topbar_color
    params[:language].to_s
  end

end
