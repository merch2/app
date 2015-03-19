require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }
    before { get :index }

    it 'array = all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index page' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:question) { create(:question) }
    before { get :show, id: question }

    it 'assign question to @q' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render show page' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { sign_in(user) }
    before { get :new }

    it 'new Question eq @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new page' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { sign_in(user) }
    context 'valid attributes' do
      it 'save question in db' do
        expect { post :create, question: attributes_for(:question) }.to change(Question, :count).by(1)
      end

      it 'redirect to show page' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'invalid attributes' do
      it 'does not save' do
        expect { post :create, question: attributes_for(:invalid_question) }.to_not change(Question, :count)
      end

      it 're-render new page' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end

  end

  describe 'DELETE #destroy' do
    before { sign_in(user) }
    it 'user delete his question' do
      question = Question.create(title:"12345", body:"12345", user_id: user.id)
      expect{ delete :destroy, id: question }.to change(Question, :count).by(-1)
    end
    it 'user delete not his question' do
      question = Question.create(title:"12345", body:"12345", user_id:555)
      expect{ delete :destroy, id: question }.to_not change(Question, :count)
    end
  end
end
