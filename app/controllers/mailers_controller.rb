class MailersController < ApplicationController
  # Send feedback emails from unauthenticated users
  # via a feedback field in the footer
  def feedback
    is_spam? and capture_spam

    mail = Mailer.feedback(params[:feedback], request)
    mail.deliver

    redirect_to :back, notice: 'Thomas just received your message. Thanks!'
  end

  private

  def is_spam?
    params[:honeypot].try(:strip) != '42'
  end

  def capture_spam
    flash.alert = 'Please resubmit your message with answer 42.'
    return redirect_to root_path(feedback: params[:feedback])
  end
end
