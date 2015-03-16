require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user) { create(:user) }
  let(:question) { create(:question) }
  #let(:answer) { create(:answer) }


  describe 'GET #new' do
    sign_in_user
    before { get :new, question_id: question }

    it 'new Answer eq @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render new page' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'valid attributes' do
      it 'save answer in db' do
        expect { post :create, question_id: question, answer: attributes_for(:answer) }.to change(question.answers, :count).by(1)
      end

      it 'redirect to show page' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'invalid attributes' do
      it 'doe not save answer in db' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer) }.to_not change(Answer, :count)
      end

      it 'render to show page' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer)
        expect(response).to render_template :new
      end
    end

  end

  describe 'DELETE #destroy' do
    sign_in_user
    it 'удаляет свой ответ' do
      post :create, question_id: question, user_id: @user, answer: attributes_for(:answer)
      expect{ delete :destroy, question_id: question, id: answer}.to change(Answer, :count).by(-1)
    end

    it 'удаляет чужой ответ' do
      post :create, question_id: question, answer: attributes_for(:answer), user_id: 555
      expect{ delete :destroy, question_id: question, id: answer}.to_not change(Answer, :count)
    end
  end

end
