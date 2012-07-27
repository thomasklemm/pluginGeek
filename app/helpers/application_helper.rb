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

  # Digest a string,
  #  if nil is given a timestamp that is valid for 10 seconds will be used
  def digest(str)
    str = ((DateTime.now.getutc.to_i)/10).round unless str.present?
    str = str.to_f.to_s if str.respond_to?(:to_f)
    str = Digest::MD5.hexdigest(str.to_s) if str.respond_to?(:to_s)
    str
  end

end
