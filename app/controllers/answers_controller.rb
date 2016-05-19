class AnswersController < ApplicationController
  before_action :load_question, only: [:create]

  def create
    @answer = @question.answers.create(answer_params.merge(user: current_user))
    redirect_to question_path(@question)
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
