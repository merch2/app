require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'POST #create' do
    before { sign_in(user) }
    context 'comment question' do
      it 'save comment in db' do
        expect { post :create, commentable: 'questions', question_id: question, comment: attributes_for(:comment), format: :js }.to change(question.comments, :count).by(1)
      end

      it 'associated with user' do
        expect { post :create, commentable: 'questions', question_id: question, comment: attributes_for(:comment), format: :js }.to change(user.comments, :count).by(1)
      end
    end

    context 'comment answer' do
      it 'save comment in db' do
        expect { post :create, commentable: 'answers', answer_id: answer, comment: attributes_for(:comment), format: :js }.to change(answer.comments, :count).by(1)
      end

      it 'associated with user' do
        expect { post :create, commentable: 'answers', answer_id: answer, comment: attributes_for(:comment), format: :js }.to change(user.comments, :count).by(1)
      end
    end

  end

end
