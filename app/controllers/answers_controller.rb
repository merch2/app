class AnswersController < ApplicationController

  include Voted

  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :question_find,      only: [:create]
  before_action :answer_find,        except: [:create]

  respond_to :html, :js, :json

  authorize_resource

  def create
    respond_with @answer = @question.answers.create(answer_params.merge(user: current_user))
  end

  def update
    @answer.update(answer_params)
    respond_with @answer
  end

  def destroy
    respond_with @answer.destroy
  end

  def best
    Answer.transaction do
      @question.answers.update_all(best: false)
      @answer.best = true
      @answer.save
    end
  end



  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

  def question_find
    @question = Question.find(params[:question_id])
  end

  def answer_find
    @answer = Answer.find(params[:id])
  end

end
