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
    @answer = Answer.find(params[:id])
    if @answer.user_id == current_user.id
      @answer.destroy!
      flash[:notice] = "Ответ удален"
      redirect_to question_path(@answer.question.id)
    else
      flash[:notice] = "Вы не автор ответа"
      redirect_to question_path(@answer.question.id)
    end
  end

  def best
    @question = Question.find(params[:question_id])
    @question.answers.each do |answer|
      answer.best = false
      answer.save
    end
    @answer = Answer.find(params[:answer_id])
    @answer.best = true
    @answer.save
    redirect_to question_path(@answer.question.id)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

end
