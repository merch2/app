require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let(:author) { create(:user) }

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

      it 'Publish_to' do
        expect(PrivatePub).to receive(:publish_to)

        post :create, commentable: 'answers', answer_id: answer, comment: attributes_for(:comment), format: :js
      end

    end



  end

  describe 'DELETE #destroy' do
    let!(:comment) { create :comment, commentable: question, user: author }
    it 'author delete comment' do
      sign_in(author)
      expect { delete :destroy, id: comment.id, format: :js }.to change(Comment, :count).by(-1)
    end
    it 'user delete comment' do
      sign_in(user)
      expect { delete :destroy, id: comment.id, format: :js }.to_not change(Comment, :count)
    end
    it 'guest delete comment' do
      expect { delete :destroy, id: comment.id, format: :js }.to_not change(Comment, :count)
    end
  end

  describe 'PATCH #update' do
    let!(:comment) { create :comment, commentable: question,  user: author }
    let(:comment_update) { patch :update, id: comment, comment: { body: 'new comment' } }
    it 'author edit comment' do
      sign_in(author)
      comment_update
      comment.reload
      expect(comment.body).to eq 'new comment'
    end

    it 'not the author edit comment' do
      sign_in(user)
      comment_update
      comment.reload
      expect(comment.body).to eq 'test comment'
    end

    it 'guest can try edit comment' do
      comment_update
      comment.reload
      expect(comment.body).to eq 'test comment'
    end

  end

end
