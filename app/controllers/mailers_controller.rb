class MailersController < ApplicationController
  # Send a feedback email from the field in the footer
  def feedback
    unless params[:honeypot].strip == '42'
      flash.alert = "Please resubmit your message with answer 42."
      return redirect_to root_path(feedback: params[:feedback])
    end

    mail = Mailer.feedback(params[:feedback], request)
    mail.deliver

    redirect_to :back, notice: 'Thomas just received your message. Thanks!'
  end
end
