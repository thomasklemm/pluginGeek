module IconHelper
  ICONS = {
    :edit => 'fa-heart',
    :github => 'fa-github-alt',
    :github_repo => 'fa-book',
    :github_stars => 'fa-star', 
    :staff_pick => 'fa-thumbs-up',
    :updated => 'fa-leaf'
    # :'html-css' => 'icon-css',
    # :javascript => 'icon-javascript',
    # :ruby => 'icon-ruby'
  }

  def icon_font_class(icon)
    ICONS[icon.to_sym] or raise "Unknown icon: #{icon}"
  end

  def icon(*args, &block)
    options = args.extract_options!
    icon_name, label_or_nil_with_block = args
    icon_font_class = icon_font_class(icon_name)
    label = block ? capture(&block) : label_or_nil_with_block
    custom_class = options.delete(:class)

    classes = ['icon fa']
    classes << icon_font_class
    classes << custom_class
    classes << 'fa-fw' if options.delete(:fixed_width)
    classes << 'fa-li' if options.delete(:list_item)
    classes << 'fa-spin' if options.delete(:spin)
    classes = classes.compact

    if label.present?
      label = content_tag(:span, label, class: 'label')
    end
    content_tag(:span, label, options.merge(class: classes.join(' ')))
  end
end

# nHelper

#   ICON_MAPPINGS = {
#     :github_repo => 'book',
#     :github_stars => 'star'
#   }

#   # Usage:
#   #
#   #  icon(:category)
#   #  icon(:category, 'Category name')
#   #  icon(:category, )
#   #
#   # Options:
#   #  title: HTML title attribute, to explain what the icon actually means
#   #  class: Additional html classes
#   #  fixed_width: boolean, use e.g. for navigation
#   #  list_item: boolean, use in conjunction with <ul class='fa-ul'> to replace list icons
#   #  spin: boolean, to animate the icon
#   #
#   def icon(kind, text=nil, options={})
#     type = ICON_MAPPINGS.fetch(kind) { raise "No mapping for icon '#{kind}' found" }
    
#     klasses = %w(icon fa)
#     klasses << "fa-#{type}"
#     klasses << 'fa-fw' if options[:fixed_width]
#     klasses << 'fa-li' if options[:list_item]
#     klasses << 'fa-spin' if options[:spin]
#     klasses << options[:class] if options[:class]
    
#     content_tag(:i, nil, class: klasses.join(' '), title: options[:title]) + text.to_s
#   end

# end


# end