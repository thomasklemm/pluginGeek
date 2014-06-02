module CategoriesHelper

  def suggest_category_update_by_email(category)
    mail_to support_email,
            icon(:mail, 'Update'),
            subject: "[Plugingeek] Update for #{ category.name }",
        body: <<-BODY.strip_heredoc.html_safe
        Hi,

        I'd like to suggest an update for #{ category.name } (#{ category_url(category) }):


    BODY
  end

end
