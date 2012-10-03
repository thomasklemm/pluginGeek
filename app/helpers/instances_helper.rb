module InstancesHelper
  def repo_updater
    @repo_updater ||= RepoUpdater.new
  end

  # FIXME: This is a duplicate to the markdown helper
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
