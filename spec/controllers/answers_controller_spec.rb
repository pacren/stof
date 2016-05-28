require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      let(:request) { post :create, params: { answer: attributes_for(:answer), question_id: question, format: :json } }

      it 'saves the new answer in the database' do
        expect { request }.to change(question.answers, :count).by(1)
      end

      it 'returns 200 status' do
        request
        expect(response.status).to eq 200
      end
    end

    context 'with invalid attributes' do
      it 'not save the new answer in the database' do
        expect{ post :create, params: {answer: attributes_for(:invalid_answer), question_id: question, format: :json} }.to_not change(Answer, :count)
      end

      it 'returns 422 status' do
        post :create, params: {answer: attributes_for(:invalid_answer), question_id: question, format: :json}
        expect(response.status).to eq 422
      end
    end
  end
end
