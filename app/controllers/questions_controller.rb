class QuestionsController < ApplicationController

  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @best   = @question.answers.where(best: true).last
  end

  def new
    @question = Question.new
  end

  def create
    @user = current_user
    @question = @user.questions.new(questions_params)
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def edit
  end

  def update
    @question.update(questions_params)
    redirect_to question_path(@question)
  end

  def destroy
    if @question.user_id == current_user.id
      @question.destroy!
      redirect_to root_path
    else
      flash[:notice] = "Вы не автор вопроса"
      render :show
    end
  end

  private

  def load_question
    @question = Question.find(params[:id])
  end

  def questions_params
    params.require(:question).permit(:title, :body)
  end

end
