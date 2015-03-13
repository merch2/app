class Answer < ActiveRecord::Base

  validates :body, presence: true
  validates :body, length: { minimum: 3 }

  belongs_to :question

end
