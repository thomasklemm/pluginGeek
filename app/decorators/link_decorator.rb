class LinkDecorator < Draper::Decorator
  delegate_all

  # Convert '@mperham' to 'https://twitter.com/mperham'
  def author_url
    url = self[:author_url] || ''
    url.start_with?('@') and url = "https://twitter.com/#{ url.gsub('@', '') }"
  end
end
