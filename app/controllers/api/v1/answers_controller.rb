class Api::V1::AnswersController < Api::V1::BaseController
  def index
    @question = Question.find(params[:question_id])
    respond_with @question.answers
  end

  def show
    @answer = Answer.find(params[:id])
    respond_with @answer
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user = current_resource_owner
    @answer.save
    respond_with @answer
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end
end