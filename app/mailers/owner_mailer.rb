class OwnerMailer < ApplicationMailer
  def send_owner(answer)
    @answer = answer
    mail to: answer.user.email
  end
end
