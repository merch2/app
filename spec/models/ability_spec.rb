require 'rails_helper'

describe Ability do

  subject(:ability) { Ability.new(user) }

  describe 'GUEST' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'ADMIN' do
    let(:user) { create :user, admin: true  }

    it { should be_able_to :manage, :all }
  end

  describe 'USER' do
    let(:user)  { create :user }
    let(:other) { create :user }

    it { should_not be_able_to :manage, :all }
    it { should     be_able_to :read,   :all }

    context 'for question' do
      it { should     be_able_to :create, Question }

      it { should     be_able_to :update,  create(:question, user: user),  user: user }
      it { should_not be_able_to :update,  create(:question, user: other), user: user }

      it { should     be_able_to :destroy, create(:question, user: user),  user: user }
      it { should_not be_able_to :destroy, create(:question, user: other), user: user }

      it { should_not be_able_to :vote_up, create(:question, user: user), user: user }
      it { should     be_able_to :vote_up, create(:question, user: other),  user: user }

      it { should_not be_able_to :vote_down, create(:question, user: user), user: user }
      it { should     be_able_to :vote_down, create(:question, user: other),  user: user }

      it { should     be_able_to :unvote, create(:question, user: other),  user: user }
    end

    context 'for answer' do
      it { should     be_able_to :create, Answer }

      it { should     be_able_to :update, create(:answer, user: user),  user: user }
      it { should_not be_able_to :update, create(:answer, user: other), user: user }

      it { should     be_able_to :destroy, create(:answer, user: user),  user: user }
      it { should_not be_able_to :destroy, create(:answer, user: other), user: user }

      it { should_not be_able_to :vote_up, create(:answer, user: user), user: user }
      it { should     be_able_to :vote_up, create(:answer, user: other), user: user }

      it { should_not be_able_to :vote_down, create(:answer, user: user), user: user }
      it { should     be_able_to :vote_down, create(:answer, user: other), user: user }
    end

    context 'for comment' do
    end






  end
end