class NoticeMailerJob < ActiveJob::Base
  queue_as :default

  def perform(answer)
    answer.question.notices do |notice|
      NoticeMailer.send_notices(self).deliver_later
    end
  end
end
