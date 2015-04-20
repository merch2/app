require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let!(:question) { create(:question) }
  let(:user) { create(:user) }
  before { sign_in(user) }

  describe 'POST #create' do
    context 'valid attributes' do
      it 'save new answer in db' do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js }.to change(question.answers, :count).by(1)
      end

      it 'rerender create tmpl' do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :create
      end
    end

    context 'invalid attributes' do
      it 'doe not save answer in db' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js }.to_not change(Answer, :count)
      end

      it 'rerender create tmpl' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
        expect(response).to render_template :create
      end
    end

  end

  describe 'DELETE #destroy' do
    it 'delete his answer' do
      answer = create(:answer, question: question, user: user)
      expect{ delete :destroy, question_id: question, id: answer, format: :js}.to change(Answer, :count).by(-1)
    end

    it 'delete not his answer' do
      answer = create(:answer, question: question)
      expect{ delete :destroy, question_id: question, id: answer, format: :js}.to_not change(Answer, :count)
    end
  end

  describe 'PATCH #update' do
    let(:answer) { create(:answer, question: question) }

    it 'assigns the requested answer to @answer' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:answer)).to eq answer
    end

    it 'assigns th question' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(assigns(:question)).to eq question
    end

    it 'changes answer attributes' do
      patch :update, id: answer, question_id: question, answer: { body: 'new body' }, format: :js
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it 'render update template' do
      patch :update, id: answer, question_id: question, answer: attributes_for(:answer), format: :js
      expect(response).to render_template :update
    end

  end

  describe 'GET #vote_up' do
    let(:answer) { create(:answer) }
    it 'save vote in db' do
      expect { post :vote_up, id: answer.id, vote: attributes_for(:vote), format: :js }.to change(Vote, :count).by(1)
    end
    it 'render vote' do
      post :vote_up, id: answer.id, vote: attributes_for(:vote), format: :js
      expect(response).to render_template :vote
    end
  end

  describe 'GET #vote_down' do
    let(:answer) { create(:answer) }
    it 'save vote in db' do
      expect { post :vote_down, id: answer.id, vote: attributes_for(:vote), format: :js }.to change(Vote, :count).by(1)
    end
    it 'render vote' do
      post :vote_down, id: answer.id, vote: attributes_for(:vote), format: :js
      expect(response).to render_template :vote
    end
  end

  describe 'GET #unvote' do
    let(:answer) { create(:answer) }
    it 'destroy vote from db' do
      post :vote_up, id: answer.id, vote: attributes_for(:vote), format: :js
      expect { post :unvote, id: answer.id, vote: attributes_for(:vote), format: :js }.to change(Vote, :count).by(-1)
    end
    it 'render votes page' do
      post :vote_up, id: answer.id, vote: attributes_for(:vote), format: :js
      post :unvote, id: answer.id, vote: attributes_for(:vote), format: :js
      expect(response).to render_template :vote
    end
  end

end
