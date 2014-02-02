#
# TitleHelper
#
# Helps setting the HTML title
# according to the requirements
# of the current path
#
module TitleHelper
  def page_title
    custom_title.presence ||
      categories_title.presence  ||
      category_title.presence ||
      repo_title.presence ||
      default_title
  end

  private

  def custom_title
    content_for(:page_title)
  end

  def categories_title
    @categories.present? and @platform.present? and "#{ @platform.name } on pluginGeek".html_safe
  end

  def category_title
    @category.present? and "#{ @category.name } on pluginGeek".html_safe
  end

  def repo_title
    @repo.present? and "#{ @repo.full_name } on pluginGeek"
  end

  def default_title
    "pluginGeek &middot; Find great Github repos".html_safe
  end
end
