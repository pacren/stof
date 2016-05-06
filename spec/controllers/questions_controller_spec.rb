require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

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
    sign_in_user

    before { get :new, params: {} }

    it 'new Question eq @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new view' do
      assert_template 'questions/new/'
    end
  end

  describe 'GET #edit' do
    sign_in_user

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
    sign_in_user

    context 'with valid attributes' do
      let(:request) { post :create, params: { question: attributes_for(:question) } }

      it 'saves the new question in the database' do
        expect { request }.to change(@user.questions, :count).by(1)
      end

      it 'redirects to show view' do
        request
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
    sign_in_user

    context 'with valid attributes' do
      it 'the requested question to @question' do
        patch :update, params: { id:question, question: attributes_for(:question) }
        assert_equal question, assigns(:question)
      end

      it 'update question' do
        patch :update, params: { id:question, question: { title: 'new question title', body: 'new question body'} }
        question.reload
        expect(question.title).to eq 'new question title'
        expect(question.body).to eq 'new question body'
      end

      it 'redirect to the updated question' do
        patch :update, params: { id:question, question: attributes_for(:question) }
        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id:question, question: { title: 'new title', body: nil} } }

      it 'does not update question' do
        expect(question.title).to_not eq 'new title'
        expect(question.body).to_not eq nil
      end

      it 're-render edit view' do
        assert_template 'questions/edit/'
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'User delete own question' do
      let(:question) { create(:question, user: @user) }

      it 'delete the question' do
        question
        expect { delete :destroy, params: { id: question } }.to change(@user.questions, :count).by(-1)
      end

      it 'redirects to index' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    context "User delete someone else's question" do
      let!(:question) { create(:question, user: user) }

      it 'does not delete the question' do
        expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
      end
    end
  end
end
