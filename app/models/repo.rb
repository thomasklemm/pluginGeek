class Repo < ActiveRecord::Base
	# Whitelisting attributes for mass assignment
	attr_accessible :full_name, :owner, :name

	# TODO: Where to set defaults in columns (important for list.js that every attribute has a 'true' value thus the field will be rendered in view)

	def update_from_github
		github_api_url = "https://api.github.com/repos/" + full_name
		http = Curl::Easy.perform(github_api_url)
		github_repo = JSON.parse(http.body_str)
		
		if github_repo["message"]
			# Something has gone wrong
			# Probably: Repo does not exist (any more)
			# => a) incorrect information
			# => b) outdated information
			return false
			# TODO: Better error handling
			# TODO: Handle renaming and owner transfership of repos
		end

		repo_attributes = Hash[:full_name => "full_name", :name => "name", 
			:description => "description", :watchers => "watchers", :forks => "forks", 
			:github_url => "html_url", :homepage_url => "homepage"]

		repo_attributes.each do |repo_attr, github_attr|
			self[repo_attr] = github_repo[github_attr]
		end

		# TODO: Integrate owner lookup more nicely
		self[:owner] = github_repo["owner"]["login"]

		puts self.inspect

	end

end
