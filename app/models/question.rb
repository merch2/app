class Question < ActiveRecord::Base

  include Votable

  validates :title, :body, presence: true

  belongs_to :user
  has_many  :answers, dependent: :destroy
  has_many  :attachments, as: :attachmentable
  #has_many :votes,       as: :votable, dependent: :destroy
  has_many  :comments, as: :commentable, dependent: :destroy

  accepts_nested_attributes_for :attachments, reject_if: proc { |attrib| attrib['file'].nil? }


end
