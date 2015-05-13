require 'rails_helper'

describe 'Answers API' do

  describe 'GET /index' do
    context 'unauthorized' do
      let!(:question) { create(:question) }
      it 'returns 401 status if no access_token' do
        get "/api/v1/questions/#{question.id}/answers", format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if invalid access_token' do
        get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: '123'
        expect(response.status).to eq 401
      end
    end

    context 'Authorized' do
      let(:access_token) { create(:access_token) }
      let(:question)     { create(:question) }
      let!(:answers)     { create_list(:answer, 2, question: question) }
      let!(:answer)      { answers.first }


      before { get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token }

      it 'return status 200' do
        expect(response).to be_success
      end

      it 'return list of questions' do
        expect(response.body).to have_json_size(2).at_path("answers")
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
        end
      end
    end
  end

  describe 'GET /show' do
    let(:access_token) { create(:access_token) }
    let(:question)     { create(:question) }
    let(:answer)       { create(:answer, question: question) }
    let!(:comments)    { create_list(:comment, 2, commentable: answer) }
    let!(:attachments) { create_list(:attachment, 2, attachmentable: answer) }
    let(:attachment)   { attachments.first }

    context 'unauthorized' do
      it 'returns 401 status if no access_token' do
        get "/api/v1/answers/#{answer.id}", format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if invalid access_token' do
        get "/api/v1/answers/#{answer.id}", format: :json, access_token: '123'
        expect(response.status).to eq 401
      end
    end

    context 'authorize' do

      before { get "/api/v1/answers/#{answer.id}", format: :json, access_token: access_token.token }

      it 'return status 200' do
        expect(response).to be_success
      end

      %w(id body created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answer/#{attr}")
        end
      end

      it 'answer with comments' do
        expect(response.body).to have_json_size(2).at_path("answer/comments")
      end

      it 'answer with attachments' do
        expect(response.body).to have_json_size(2).at_path("answer/attachments")
      end

      it 'url attachments' do
        expect(response.body).to be_json_eql(attachment.file.to_json).at_path("answer/attachments/1/file")
      end


    end
  end

  describe 'POST /create' do
    let(:access_token) { create(:access_token) }
    let!(:question) { create(:question) }

    context 'unauthorized' do
      it 'returns 401 status if no access_token' do
        post "/api/v1/questions/#{question.id}/answers", answer: attributes_for(:answer), format: :json
        expect(response.status).to eq 401
      end

      it 'returns 401 status if invalid access_token' do
        post "/api/v1/questions/#{question.id}/answers", access_token: '123', answer: attributes_for(:answer), format: :json
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do

      it 'return status 201' do
        post "/api/v1/questions/#{question.id}/answers", access_token: access_token.token, answer: attributes_for(:answer), question: question, format: :json
        expect(response.status).to eq 201
      end

      it 'count questions +1' do
        expect{ post "/api/v1/questions/#{question.id}/answers", access_token: access_token.token, answer: attributes_for(:answer), format: :json}.to change(Answer, :count).by(1)
      end
    end

  end

end