class Question < ActiveRecord::Base

  validates :title, :body, presence: true

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable

  accepts_nested_attributes_for :attachments
end
