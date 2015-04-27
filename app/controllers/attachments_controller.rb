class AttachmentsController < ApplicationController

  before_action :load_attachment

  respond_to :js

  def destroy
    respond_with @attachment.destroy
  end

  private

  def load_attachment
    @question = Question.find(params[:question_id])
    @attachment = Attachment.find(params[:id])
  end

end
