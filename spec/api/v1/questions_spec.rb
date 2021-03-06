require 'rails_helper'

describe 'Questions API' do
  describe 'GET /index' do
    it_behaves_like "API Authenticable"

    context 'Authorized' do
      let(:access_token) { create(:access_token) }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let!(:answer) { create(:answer, question: question) }

      before { get '/api/v1/questions', format: :json, access_token: access_token.token }

      it 'return status 200' do
        expect(response).to be_success
      end

      it 'return list of questions' do
        expect(response.body).to have_json_size(2).at_path("questions")
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
        end
      end


      context 'Answers' do
        it 'included in question object' do
          expect(response.body).to have_json_size(1).at_path("questions/0/answers")
        end

        %w(id body created_at updated_at).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("questions/0/answers/0/#{attr}")
          end
        end

      end

    end

    def do_request(options = {})
      get '/api/v1/questions', { format: :json}.merge(options)
    end

  end

  describe 'GET /show' do
    let(:access_token) { create(:access_token) }
    let(:question) { create(:question) }
    let!(:comments) { create_list(:comment, 2, commentable: question) }
    let!(:attachments) { create_list(:attachment, 2, attachmentable: question) }
    let(:attachment) { attachments.first }

    it_behaves_like "API Authenticable"

    context 'authorize' do

      before { get "/api/v1/questions/#{question.id}", format: :json, access_token: access_token.token }

      it 'return status 200' do
        expect(response).to be_success
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("question/#{attr}")
        end
      end

      it 'question with comments' do
        expect(response.body).to have_json_size(2).at_path("question/comments")
      end

      it 'question with attachments' do
        expect(response.body).to have_json_size(2).at_path("question/attachments")
      end

      it 'url attachments' do
        expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("question/attachments/1/url")
      end


    end

    def do_request(options = {})
      get "/api/v1/questions/#{question.id}", { format: :json}.merge(options)
    end

  end

  describe 'POST /create' do
    let(:access_token) { create(:access_token) }

    it_behaves_like "API Authenticable"

    context 'authorized' do
      it 'return status 201' do
        post "/api/v1/questions", access_token: access_token.token, question: attributes_for(:question), format: :json
        expect(response.status).to eq 201
      end

      it 'count questions +1' do
        expect{ post "/api/v1/questions", access_token: access_token.token, question: attributes_for(:question), format: :json}.to change(Question, :count).by(1)
      end
    end

    def do_request(options = {})
      post "/api/v1/questions", { format: :json}.merge(options)
    end
  end
end