class Answer < ActiveRecord::Base

  include Votable

  default_scope { order(:created_at) }
  validates :body, presence: true
  validates :body, length: { minimum: 3 }

  belongs_to :question
  belongs_to :user
  has_many   :attachments, as: :attachmentable
  #has_many  :votes,       as: :votable, dependent: :destroy
  has_many   :comments,   as: :commentable, dependent: :destroy

  accepts_nested_attributes_for :attachments

  after_create :send_to_question_owner
  after_create :send_notices

  private
  def send_to_question_owner
    OwnerMailer.delay.send_owner(self)
  end

  def send_notices
    answer.question.notices do |notice|
      NoticeMailer.delay.send_notices(self)
    end
  end
end
