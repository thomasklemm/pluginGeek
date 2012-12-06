module UrlHelper

  # Construct a path, will join array with slashes
  def path(*args)
    '/' + args.join('/')
  end

  def current_path?(*args)
    current_page?(path(args)) ? 'active' : nil
  end
end
