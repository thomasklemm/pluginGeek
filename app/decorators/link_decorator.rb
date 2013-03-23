class LinkDecorator < Draper::Decorator
  delegate_all

  # Convert '@mperham' to 'https://twitter.com/mperham'
  def author_url
    url = self[:author_url] || ''
    url.start_with?('@') and url = "https://twitter.com/#{ url.gsub('@', '') }"
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
