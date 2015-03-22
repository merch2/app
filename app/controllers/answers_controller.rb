class AnswersController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @user = current_user
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = @user
    @answer.save
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    @question = @answer.question
  end

  def destroy
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    if @answer.user_id == current_user.id
      @answer.destroy!
      flash[:notice] = "Ответ удален"
      #redirect_to question_path(@answer.question.id)
    else
      flash[:notice] = "Вы не автор ответа"
      #redirect_to question_path(@answer.question.id)
    end
  end

  def best
    @question = Question.find(params[:question_id])
    @best = @question.answers.where(best: true).first
    @answer = Answer.find(params[:answer_id])
    @answer.best = true
    if @answer.save
      @best.best = false
      @best.save
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

end
