module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  def liked_by(user)
    if votes.where(user_id: user.id, like: 1).exists?
      votes.where(user_id: user.id, like: 1).delete_all
    else
      votes.create(user_id: user.id, like: 1)
    end
  end

  def disliked_by(user)
    if votes.where(user_id: user.id, like: -1).exists?
      votes.where(user_id: user.id, like: -1).delete_all
    else
      votes.create(user_id: user.id, like: -1)
    end
  end
end