class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end

  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can     :create,     [Question, Answer, Comment]
    can     :update,     [Question, Answer], user: user
    can     :destroy,    [Question, Answer, Notice], user: user
    can     :create, Notice do |object|
      object.new_record?
    end

    can    [:update, :destroy], Comment, user_id: user.id
    can     :best, Answer
    cannot  :best, Answer, user_id: user.id


    alias_action :vote_up, :vote_down, :to => :vote

    can     :vote,    [Question, Answer] do |object|
      object.votes.where(user_id: user.id).exists? == false
    end
    cannot  :vote,    [Question, Answer], user_id: user.id


    can     :unvote,       [Question, Answer] do |object|
      object.votes.where(user_id: user.id).exists? == true
    end
    cannot  :unvote,       [Question, Answer], user_id: user.id

  end
end
