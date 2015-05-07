class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :load_commentable, except: [:edit, :update, :destroy]

  respond_to :js, :html

  authorize_resource

  def create
    respond_with @comment = @commentable.comments.create(comments_params.merge(user: current_user))
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @comment.update(comments_params)
    redirect_to question_path(@comment.commentable)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
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
