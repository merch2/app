require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  describe 'GET #new' do
    before { get :new, question_id: question }

    it 'new Answer eq @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render new page' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do

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

end
