module IconHelper

  ICON_MAPPINGS = {
    :github_repo => 'book',
    :github_stars => 'star'
  }

  # Usage:
  #
  #  icon(:category)
  #  icon(:category, 'Category name')
  #  icon(:category, )
  #
  # Options:
  #  title: HTML title attribute, to explain what the icon actually means
  #  class: Additional html classes
  #  fixed_width: boolean, use e.g. for navigation
  #  list_item: boolean, use in conjunction with <ul class='fa-ul'> to replace list icons
  #  spin: boolean, to animate the icon
  #
  def icon(kind, text=nil, options={})
    type = ICON_MAPPINGS.fetch(kind) { raise "No mapping for icon '#{kind}' found" }
    
    klasses = %w(fa)
    klasses << "fa-#{type}"
    klasses << 'fa-fw' if options[:fixed_width]
    klasses << 'fa-li' if options[:list_item]
    klasses << 'fa-spin' if options[:spin]
    klasses << options[:class] if options[:class]
    
    content_tag :i, text, class: klasses.join(' '), title: options[:title]
  end

end