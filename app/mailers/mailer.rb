class Mailer < ActionMailer::Base
  default from: "thomas@plugingeek.com",
          to:   "thomas@plugingeek.com",
          subject: "New message on Plugingeek"

  # Send feedback emails from the footer
  def feedback(body, request)
    @body = body
    @request = request
    mail
  end
end
