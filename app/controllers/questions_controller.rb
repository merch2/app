class QuestionsController < ApplicationController
  include Voted

  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  before_action :build_answer, only: :show
  after_action  :publish, only: :create

  respond_to :html

  authorize_resource

  def index
    respond_with(@questions = Question.all)
  end

  def show
    @best = @question.answers.where(best: true).last
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def edit
  end

  def create
    respond_with(@question = current_user.questions.create(questions_params))
  end

  def update
    @question.update(questions_params)
    respond_with @question
  end

  def destroy
    respond_with(@question.destroy)
  end


  private

  def load_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file,:id, :_destroy])
  end

  def build_answer
    @answer = Answer.new
  end

  def publish
    PrivatePub.publish_to "/questions", question: @question.to_json
  end

end
