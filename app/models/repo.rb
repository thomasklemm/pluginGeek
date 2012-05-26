class Repo < ActiveRecord::Base
	# Whitelisting attributes for mass assignment
	attr_accessible :owner, :name

	def full_name
		"#{owner}/#{name}"
	end
end
