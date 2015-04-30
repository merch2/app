class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :load_commentable

  respond_to :js

  def create
    respond_with @comment = @commentable.comments.create(comments_params.merge(user: current_user))
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
