class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:create]

  def create
    @answer = @question.answers.build(answer_params.merge(user: current_user))
    respond_to do |format|
      if @answer.save
        format.json { render json: @answer, include: ['user'] }
      else
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    respond_to do |format|
      if @answer.update(answer_params)
        format.json { render json: @answer, include: ['user'] }
      else
        format.json { render json: @answer.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
