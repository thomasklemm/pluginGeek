class MailersController < ApplicationController
  # Send a feedback email from the field in the footer
  def feedback
    if params[:honeypot].present?
      redirect_to :back, alert: 'No spamming please.'
    end

    if params[:feedback_body].blank?
      redirect_to :back, alert: 'Could not send an empty message'
    end

    mail = Mailer.feedback(params[:feedback_body], request)
    mail.deliver

    redirect_to :back, notice: 'Thomas just received your message. Thanks!'
  end
end
