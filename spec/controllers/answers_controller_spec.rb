require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question) }
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
      expect{ delete :destroy, question_id: question, id: answer}.to change(Answer, :count).by(-1)
    end

    it 'delete not his answer' do
      answer = create(:answer, question: question)
      expect{ delete :destroy, question_id: question, id: answer}.to_not change(Answer, :count)
    end
  end

end
