class NoticesController < ApplicationController

  respond_to :js

  authorize_resource

  def create
    @question = Question.find(params[:question_id])
    @notice = Notice.create(user: current_user, question: @question)
  end

  def destroy
    @notice = Notice.find(params[:id])
    @notice.destroy
  end

end
