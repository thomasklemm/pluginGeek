#
# TitleHelper
#
# Helps setting the HTML title
# according to the requirements
# of the current path
#
module TitleHelper
  def page_title
    custom_title ||
      platform_title  ||
      category_title ||
      repo_title ||
      default_title
  end

  private

  def custom_title
    content_for(:page_title)
  end

  def platform_title
    @platform && "#{ @platform.name } on pluginGeek".html_safe
  end

  def category_title
    @category &&  "#{ @category.name } on pluginGeek".html_safe
  end

  def repo_title
    @repo && "#{ @repo.name } on pluginGeek"
  end

  def default_title
    "pluginGeek &middot; Find great Github repos".html_safe
  end
end
