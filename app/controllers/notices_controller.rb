class NoticesController < ApplicationController

  respond_to :html

  authorize_resource

  def create
    @question = Question.find(params[:question_id])
    @notice = Notice.create(user: current_user, question: @question)
    redirect_to question_path(@question)
  end

  def destroy
    @notice = Notice.find(params[:id])
    question = @notice.question
    @notice.destroy
    redirect_to question_path(question)
  end

end
