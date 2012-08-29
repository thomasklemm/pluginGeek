module InstancesHelper
  def category_updater
    @category_updater ||= CategoryUpdater.new
  end

  def repo_updater
    @repo_updater ||= RepoUpdater.new
  end

  def markdown
    # See Redcarpet options: https://github.com/tanoku/redcarpet
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, safe_links_only: true,
      with_toc_data: true, hard_wrap: true, no_intra_emphasis: true, autolink: true)
  end

  # Review: Does caching the Rails logger in an instance variable make sense?
  def logger
    @logger ||= Rails.logger
  end
end

# Source:
# Rails 3 helper method available in model -
#   http://stackoverflow.com/questions/5524835/rails-3-helper-method-available-in-model
