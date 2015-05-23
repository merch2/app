class NoticeMailer < ApplicationMailer
  def send_notices(answer)
    @answer = answer

    mail to: answer.user.email
  end
end
