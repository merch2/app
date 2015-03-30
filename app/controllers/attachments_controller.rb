class AttachmentsController < ApplicationController

  def destroy
    @question = Question.find(params[:question_id])
    @attachment = Attachment.find(params[:id])
    @attachment.destroy!
    redirect_to question_path(@question)
  end
end
