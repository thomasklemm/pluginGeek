class User < ActiveRecord::Base
  # Whitelist attributes for mass-assignment
  attr_accessible :login

  def create_and_update_from_github
    update_from_github
  end

  def update_from_github
    github = Github.new
    github_user = github.users.get(login)

    %w(login name html_url).each do |attr|
      self[attr] = github_user[attr]
    end

    self.save
  end

end
