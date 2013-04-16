class Array
  # Generate a cache_key for the array's items
  # based on the items' individual cache keys or their string representations
  # Digests long keys to remain within Memcached key length limits
  def cache_key
    key = map { |item| item.respond_to?(:cache_key) ? item.cache_key : item }.to_param

    key = Digest::MD5.hexdigest(key) if key.length > 40
    key = 'empty' if key == ''

    key
  end
end
