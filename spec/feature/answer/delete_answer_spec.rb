require_relative '../feature_helper'

feature 'Answer delete' do
  given (:autor) { create :user }
  given (:user) { create :user }
  given (:question) { create :question }
  given (:answer) { create :answer, question: question }

  scenario 'Non-authenticated user try delete answer'
  scenario 'Author user delete his answer'
  scenario 'Authenticated user try to delete other user answer'
end
