module ApplicationHelper
  def eye_catcher_message
    case params[:language]
      when /ruby/ then "So you're looking for an awesome <span class='type'>Ruby Gem?</span>"
      when /javascript/ then "So you're looking for an awesome <span class='type'>Javascript Plugin?<span>"
      when /webdesign/ then "So you're looking <br />for some great <span class='type'>Webdesign Inspiration?</span>"
      when /mobile|ios|android/ then "So you're looking <br />for a handy <span class='type'>Mobile Development Plugin?<span>"
      else "So you're looking <br />for an awesome <span class='type'>Webdevelopment Plugin?<span>"
      end
  end
end
