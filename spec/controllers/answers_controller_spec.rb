require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question) }


  describe 'POST #create' do
    sign_in_user
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
    sign_in_user
    it 'delete his answer' do
      post :create, question_id: question, user_id: @user, answer: attributes_for(:answer), format: :js
      expect{ delete :destroy, question_id: question, id: answer}.to change(Answer, :count).by(-1)
    end

    it 'delete not his answer' do
      post :create, question_id: question, answer: attributes_for(:answer), user_id: 555, format: :js
      expect{ delete :destroy, question_id: question, id: answer}.to_not change(Answer, :count)
    end
  end

end
