module NavigationHelper
  def active_on_path(path)
    'is_active' if path == request.path
  end
end