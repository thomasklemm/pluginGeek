class Repo < ActiveRecord::Base
	# Whitelisting attributes for mass assignment
	attr_accessible :full_name, :owner, :name

	# Attribute defaults
	def description
		self[:description] or "No description given."
	end

	def homepage_url
		self[:homepage_url] or ""
	end


	# Github attribute mapping
	GITHUB_ATTRIBUTES = Hash[:full_name => "full_name", :name => "name", 
			:description => "description", :watchers => "watchers", :forks => "forks", 
			:github_url => "html_url", :homepage_url => "homepage", :owner => ["owner", "login"] ]
	GITHUB_REPOS_API_URL = "https://api.github.com/repos/"

	def first_update_from_github
		if update_from_github
			logger.info "Repo '#{full_name}' successfully updated for the first time with first_update_from_github."
			return true
		else
			logger.error "Repo '#{full_name}' could not be found on Github. Aborting."
			return false
		end
	end

	def self.update_all_repos_from_github
		self.find_each(batch_size: 100) do |repo|
			repo.regular_update_from_github
		end
	end

	# TODO: May only update attributes that can change like description, homepage_url, watchers, forks?
	def regular_update_from_github
		if update_from_github
			logger.info "Repo '#{full_name}' successfully updated."
			return true
		else
			logger.error "Repo '#{full_name}' could not be found on Github. Aborting."
			return false
		end
	end

	# CHECK: Should this method be split up?
	def update_from_github

		github_api_url = GITHUB_REPOS_API_URL + full_name
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

		GITHUB_ATTRIBUTES.each do |repo_attr, github_attr|
			# Casts String to Array
			if github_attr.kind_of? String
				h = github_attr.split
			else
				h = github_attr
			end

			# Recursive lookup and assignment
			h.length.times do |index|
				if index.zero?
					self[repo_attr] = github_repo[h[index]]
				else
					self[repo_attr] = self[repo_attr][h[index]]
				end
			end				
		end

		# Save
		self.save
	end



end
