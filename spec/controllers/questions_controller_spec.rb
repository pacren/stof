require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before do
      get :index
    end

    it 'populates an array of questions' do
      assert_equal questions, assigns(:questions)
    end

    it 'render index view' do
      assert_template 'questions/index'
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: question }
    end

    it 'the requested question to @question' do
      assert_equal question, assigns(:question)
    end

    it 'render show view' do
      assert_template 'questions/show/'
    end
  end

  describe 'GET #new' do
    before { get :new, params: {} }

    it 'new Question eq @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new view' do
      assert_template 'questions/new/'
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: { id: question }
    end

    it 'the requested question to @question' do
      assert_equal question, assigns(:question)
    end

    it 'render edit view' do
      assert_template 'questions/edit/'
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save the new question in the database' do
        expect{ post :create, params: {question: attributes_for(:question)} }.to change(Question, :count).by(1)
      end

      it 'redirect to question path' do
        post :create, params: {question: attributes_for(:question)}
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'save the new question in the database' do
        expect{ post :create, params: {question: attributes_for(:invalid_question)} }.to_not change(Question, :count)
      end

      it 'rerender new view' do
        post :create, params: {question: attributes_for(:invalid_question)}
        assert_template 'questions/new/'
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'the requested question to @question' do
        patch :update, params: { id:question, question: attributes_for(:question) }
        assert_equal question, assigns(:question)
      end

      it 'update question' do
        patch :update, params: { id:question, question: { title: 'new title', body: 'new body'} }
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirect to the updated question' do
        patch :update, params: { id:question, question: attributes_for(:question) }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id:question, question: { title: 'new title', body: nil} } }

      it 'does not update question' do
        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end

      it 're-render edit view' do
        assert_template 'questions/edit/'
      end
    end
  end

  describe 'DELETE #destroy' do
    before { question }

    it 'deletes question' do
      expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
    end

    it 'redirect to index' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end
end
