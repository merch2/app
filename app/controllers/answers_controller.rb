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
    @question.answers.update_all(best: false)
    @answer.best = true
    @answer.save

    #@best = @question.answers.where(best: true).first
    #@answer.best = true
    #if @answer.save
    #  @best.best = false
    #  @best.save
    #end
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
