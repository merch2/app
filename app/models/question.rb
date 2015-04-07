class Question < ActiveRecord::Base

  validates :title, :body, presence: true

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable
  has_many :votes,       as: :votable, dependent: :destroy
  accepts_nested_attributes_for :attachments, reject_if: proc { |attrib| attrib['file'].nil? }

  def liked_by(user)
    if votes.where(user_id: user.id, like: true).exists?
      votes.where(user_id: user.id, like: true).delete_all
    else
      votes.create(user_id: user.id, like: true)
    end
  end

  def disliked_by(user)
    if votes.where(user_id: user.id, like: false).exists?
      votes.where(user_id: user.id, like: false).delete_all
    else
      votes.create(user_id: user.id, like: false)
    end
  end

end
