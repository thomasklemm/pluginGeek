class KnightUpdater

  def self.update_knight_serial
    Rails.logger.info 'Processing a serial Knight update...'
    
    # Call both serial updaters
    RepoUpdater.update_repos_serial
    CategoryUpdater.update_categories_serial
    
    Rails.logger.info 'Finished processing a serial Knight update'
  end

  def self.update_knight_sidekiq
    Rails.logger.info 'Scheduling a Sidekiq-powered Knight update...'

    # Call both sidekiq-powered async updaters
    RepoUpdater.update_repos_sidekiq
    sleep 10
    CategoryUpdater.update_categories_sidekiq

    Rails.logger.info 'Finished scheduling a Sidekiq-powered Knight update...'
  end

end