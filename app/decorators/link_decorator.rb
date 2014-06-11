class LinkDecorator < Draper::Decorator
  delegate_all

  def categories
    @categories ||= (model.categories | categories_of_repos).uniq.sort_by(&:score).reverse
  end

  private

  def categories_of_repos
    @categories_of_repos ||= repos.includes(:categories).flat_map(&:categories)
  end
end
