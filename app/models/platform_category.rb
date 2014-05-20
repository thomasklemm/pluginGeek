class PlatformCategory < ActiveRecord::Base
  belongs_to :platform, counter_cache: :categories_count
  belongs_to :category
end
