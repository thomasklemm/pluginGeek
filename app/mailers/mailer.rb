class Mailer < ActionMailer::Base
  default from: "thomas@plugingeek.com",
          to: "thomas@plugingeek.com",
          subject: "New message on Plugingeek"

  # Send feedback emails from the footer
  def feedback(body, user)
    @body = body
    @user = user
    mail
  end
end
