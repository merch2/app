class AttachmentsController < ApplicationController

  def destroy
    @question = Question.find(params[:question_id])
    @attachment = Attachment.find(params[:id])
    @attachment.destroy!
  end
end
