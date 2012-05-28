class User < ActiveRecord::Base
  attr_accessible :html_url, :login, :name
end
