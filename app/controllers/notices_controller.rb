class NoticesController < ApplicationController

  respond_to :html

  def create
    @question = Question.find(params[:question_id])
    @notice = Notice.create(user: current_user, question: @question)
    respond_with @notice
  end

end
