require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe 'POST #create' do
    sign_in_user

    context 'with valid attributes' do
      let(:request) { post :create, params: { answer: attributes_for(:answer), question_id: question } }

      it 'saves the new answer in the database' do
        expect { request }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question show' do
        request
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'save the new answer in the database' do
        expect{ post :create, params: {answer: attributes_for(:invalid_answer), question_id: question} }.to_not change(Answer, :count)
      end

      it 'redirect to question show' do
        post :create, params: {answer: attributes_for(:invalid_answer), question_id: question}
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end
  end
end
