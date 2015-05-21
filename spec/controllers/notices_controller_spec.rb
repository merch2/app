require 'rails_helper'

RSpec.describe NoticesController, type: :controller do

  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }

    context 'Auth user' do
      before { sign_in(user) }

      it 'save notice in db' do
        expect{ post :create, question_id: question, user_id: user }.to change(Notice, :count).by(1)
      end

      it 'associate notice with question' do
        expect{ post :create, question_id: question, user_id: user}.to change(question.notices, :count).by(1)
      end

      it 'associate notice with user' do
        expect{ post :create, question_id: question, user_id: user}.to change(user.notices, :count).by(1)
      end

    end

    context 'Guest' do
      it 'guest try subscribe' do
        expect{ post :create, question_id: question, user_id: user }.to_not change(Notice, :count)
      end
    end

  end

  describe 'DELETE #destroy' do
    let(:author) { create(:user) }
    let(:user)   { create(:user) }
    let(:question) { create(:question) }
    let!(:notice) { create(:notice, user: author, question: question) }

    it 'author try destroy notice' do
      sign_in(author)
      expect{ delete :destroy, id: notice }.to change(Notice, :count).by(-1)
    end

    it 'guest try destroy notice' do
      expect{ delete :destroy, id: notice }.to_not change(Notice, :count)
    end

    it 'user try destroy notice' do
      sign_in(user)
      expect{ delete :destroy, id: notice }.to_not change(Notice, :count)
    end

  end

end
