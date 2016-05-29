require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

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

  describe 'PATCH #update' do
    sign_in_user

    context 'with valid attributes' do
      it 'the requested answer to @answer' do
        patch :update, params: { id:answer, question: question, answer: attributes_for(:answer), format: :json }
        assert_equal answer, assigns(:answer)
      end

      it 'update answer' do
        patch :update, params: { id:answer, question: question, answer: { body: 'new answer body'}, format: :json }
        answer.reload
        expect(answer.body).to eq 'new answer body'
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id:answer,question: question, answer: {body: nil}, format: :json } }

      it 'does not update answer' do
        expect(answer.body).to_not eq nil
      end
    end
  end
end
