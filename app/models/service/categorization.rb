class Service::Categorization < ActiveRecord::Base
  belongs_to :service
  belongs_to :category
end
