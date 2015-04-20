class AnswersController < ApplicationController

  include Voted

  before_action :authenticate_user!, only: [:create, :destroy, :vote_up, :vote_down, :unvote]
  before_action :question_find,      only: [:create]
  before_action :answer_find,        except: [:create]

  def create
    @user = current_user
    @answer = @question.answers.new(answer_params)
    @answer.user = @user
    respond_to do |format|
      if @answer.save
        format.html { render partial: 'questions/answers', layout: false }
        format.json { render json: @answer }
      else
        format.html { render text: @answer.errors.full_messages.join("\n"), status: :unprocessable_entity }
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @answer.update(answer_params)
        #format.html { render partial: 'questions/answers', layout: false }
        #format.json { render json: @answer }
        render 'update'
      else
        format.html { render text: @answer.errors.full_messages.join("\n"), status: :unprocessable_entity }
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
    end
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
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

  def question_find
    @question = Question.find(params[:question_id])
  end

  def answer_find
    @answer = Answer.find(params[:id])
  end

end
