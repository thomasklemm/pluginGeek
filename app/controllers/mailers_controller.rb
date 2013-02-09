class MailersController < ApplicationController
  # Send a feedback email from the field in the footer
  def feedback
    feedback_body = params[:feedback_body]
    user = current_user

    # Only send mail if body is present
    if feedback_body.present?
      Mailer.feedback(feedback_body, user).deliver
      redirect_to :back, notice: 'Thomas just received your message. Thanks!'
    else
      redirect_to :back, alert: 'Cannot send an message, sorry. Just write something!'
    end
  end
end
