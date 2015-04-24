class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :load_commentable

  def create
    @comments = Comment.all
    @comment = @commentable.comments.new(comments_params)
    @comment.user = current_user
    @comment.save
    #redirect_to question_path(@question)
  end

  private
  def comments_params
    params.require(:comment).permit(:body, :user_id, :commentable_type, :commentable_id)
  end

  def load_commentable
    parameter = (params[:commentable].singularize + '_id').to_sym
    @commentable = params[:commentable].classify.constantize.find(params[parameter])
  end

end
