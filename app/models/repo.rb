class Repo < ActiveRecord::Base
	# Whitelisting attributes for mass assignment
	attr_accessible :owner, :name
end
