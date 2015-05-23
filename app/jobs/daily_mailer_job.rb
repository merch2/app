class DailyMailerJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    User.find_each do |user|
      DailyMailer.digest(user).deliver_later
    end
  end
end
