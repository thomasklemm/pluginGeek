module ReposHelper

  def suggest_repo_update_by_email(repo)
    mail_to support_email,
      icon(:mail, 'Update'),
      subject: "[Plugingeek] Update for #{ repo.owner_and_name }",
      body: <<-BODY.strip_heredoc.html_safe
        Hi,

        I'd like to suggest an update for #{ repo.owner_and_name } (#{ repo_url(repo) }):


      BODY
  end

end
