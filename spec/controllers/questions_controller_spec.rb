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

    it "new Question eq @question" do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it "render new view" do
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

      it "redirect to question path" do
        post :create, params: {question: attributes_for(:question)}
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'save the new question in the database' do
        expect{ post :create, params: {question: attributes_for(:invalid_question)} }.to_not change(Question, :count)
      end

      it "rerender new view" do
        post :create, params: {question: attributes_for(:invalid_question)}
        assert_template 'questions/new/'
      end
    end
  end
end
