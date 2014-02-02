class PlatformCategory < ActiveRecord::Base
  belongs_to :platform
  belongs_to :category
end
