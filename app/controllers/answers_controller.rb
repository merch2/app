class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :question_find
  before_action :answer_find,        except: [:create]

  def create
    @user = current_user
    @answer = @question.answers.new(answer_params)
    @answer.user = @user
    @answer.save
  end

  def update
    @answer.update(answer_params)
  end

  def destroy
    if @answer.user_id == current_user.id
      @answer.destroy!
    end
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
    params.require(:answer).permit(:body)
  end

  def question_find
    @question = Question.find(params[:question_id])
  end

  def answer_find
    @answer = Answer.find(params[:id])
  end

end
