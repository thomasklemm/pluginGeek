class Repo < ActiveRecord::Base

  # Whitelisting attributes for mass assignment
  attr_accessible :full_name, :owner, :name
  # category_list only needs to be accessible in development (and maybe test) environment
  attr_accessible :category_list if Rails.env.development? || Rails.env.test?

  # Default scope
  default_scope order: 'knight_score desc'

  # Validations
  validates :full_name, uniqueness: true

  # FriendlyId
  extend FriendlyId
  friendly_id :full_name

  # Tagging
  acts_as_ordered_taggable_on :categories

  # Attribute defaults
  def description
    self[:description] or "No description given."
  end

  def homepage_url
    self[:homepage_url] or ""
  end

  ###
  #   Updating Jobs
  ###

  # Github Attribute Mapping
  GITHUB_REPO_ATTRIBUTES = Hash[full_name: 'full_name', name: 'name',
      description: 'description', watchers: 'watchers', forks: 'forks',
      github_url: 'html_url', homepage_url: 'homepage', owner: ['owner', 'login'], github_updated_at: 'updated_at' ]
  GITHUB_API_BASE_URL = 'https://api.github.com/'

  # Update repos
  #   by running 'Repo.update_repos_from_github'
  def self.update_repos_from_github
    conn = Excon.new(GITHUB_API_BASE_URL)
    # REVIEW: Rails API Doc suggests not using find_each for less than 1000 records
    Repo.find_each(batch_size: 200) do |repo|
      if repo.update_repo(conn)
        # success
      else
        # error
        # repo.update_attribute(:manual_work_required, true)
      end
    end
    puts "'Repo.update_repos_from_github' successfully finished."
  end

  # Initialize (or manually update) repo
  #   by calling 'initialize_repo_from_github' on repo
  def initialize_repo_from_github
    if update_repo
      # success
      true
    else
      # error
      false
    end
  end

  def update_repo
    # Request
    conn ||= Excon.new(GITHUB_API_BASE_URL)
    path = '/repos/' + full_name
    res = conn.get(path: path)

    # Error Handling
    #   e.g. mark with flag for manual handling
    #   be sure to return in case of repo renamed or non-existent etc on github
    res.status != 200 and return puts "Updating #{full_name} failed."

    # Success Handling
    github_repo = JSON.parse(res.body)

    # Update every attribute individually
    recursive_update_of_repo_attributes(github_repo)

    # Remove Homepage if it is the same as github_url
    #   (does not work if https:// is substituted with http://)
    self[:homepage_url] = nil if homepage_url == github_url

    # Calculate Knight Score
    self[:knight_score] = knight_score(github_repo)
    # Save Repo
    save
  end

  def recursive_update_of_repo_attributes(github_repo)
    # Mapped attributes
    GITHUB_REPO_ATTRIBUTES.each do |repo_attr, github_attr|
      # Cast String to Array
      h = github_attr.kind_of?(String) ? github_attr.split : github_attr

      # Recursive lookup and assignment
      h.size.times do |index|
        self[repo_attr] = index.zero? ? github_repo[h[index]] : self[repo_attr][h[index]]
      end
    end
  end

end
