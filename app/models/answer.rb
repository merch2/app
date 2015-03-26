class Answer < ActiveRecord::Base

  default_scope { order(:created_at) }
  validates :body, presence: true
  validates :body, length: { minimum: 3 }

  belongs_to :question
  belongs_to :user

end
