module NavigationHelper

  # nvativation class active if scope fits
  def active_scope(s)
    'active' if s.to_s == scope
  end

end