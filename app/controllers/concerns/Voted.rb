module Voted
  extend ActiveSupport::Concern

  included do
    before_action :get_votable, only: [:vote_up, :vote_down, :unvote]
  end

  def vote_up
    if @votable.liked_by(current_user)
      #render json: @votable
      redirect_to question_path(@votable)
    else
      render :forbidden
    end
  end

  def vote_down
    if @votable.disliked_by(current_user)
      #render json: @votable
      redirect_to question_path(@votable)
    else
      render :forbidden
    end
  end

  def get_votable
    @votable = controller_name.classify.constantize.find(params[:id])
  end

end