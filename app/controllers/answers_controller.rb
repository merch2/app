class AnswersController < ApplicationController
  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answers_params)
    if @answer.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def answers_params
    params.require(:answer).permit(:body)
  end
end
