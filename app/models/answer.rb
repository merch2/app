class Answer < ActiveRecord::Base

  default_scope { order(:created_at) }
  validates :body, presence: true
  validates :body, length: { minimum: 3 }

  belongs_to :question
  belongs_to :user
  has_many   :attachments, as: :attachmentable

  accepts_nested_attributes_for :attachments
end
