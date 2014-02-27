# Search
#
# Usage:
#  @search = Search.new(params[:q])
#  @search.results[:categories]
#  @search.results[:repos]
#
class Search
  include ActiveModel::Model

  def initialize(q=nil)
    @q = q
  end
  attr_reader :q

  def results
    return {} if q.blank?
    @results ||= { categories: Category.search(q), repos: Repo.search(q) }
  end
end