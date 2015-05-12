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
    respond_with @answer = current_resource_owner.questions.answers.create(answer_params)
  end

  private
  def answer_params
    params.require(:answer).permit(:body)
  end
end