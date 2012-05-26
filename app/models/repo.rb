class Repo < ActiveRecord::Base
	# Whitelisting attributes for mass assignment
	attr_accessible :full_name, :owner, :name

	def update_from_github
		gh_url = "https://api.github.com/repos/" + full_name
	end

end
