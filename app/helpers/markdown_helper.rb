module MarkdownHelper
  def markdown
    # See Redcarpet options: https://github.com/tanoku/redcarpet
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, safe_links_only: true,
      with_toc_data: true, hard_wrap: true, no_intra_emphasis: true, autolink: true)
  end
end

# Source:
# Rails 3 helper method available in model -
#   http://stackoverflow.com/questions/5524835/rails-3-helper-method-available-in-model
