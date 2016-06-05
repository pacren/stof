require_relative '../feature_helper'

feature 'Answer delete' do
  given (:author) { create :user }
  given (:user) { create :user }
  given (:question) { create :question }
  given!(:answer) { create :answer, question: question, user: author}

  scenario 'Non-authenticated user try delete answer' do
    visit question_path(question)

    within '.answer__box' do
      expect(page).to_not have_link('Delete answer')
    end
  end
  scenario 'Author user delete his answer', js: true do
    sign_in(author)
    visit question_path(question)

    within "#answer_#{answer.id}" do
      click_on 'Delete answer'

      expect(page).to_not have_content "#{answer.body}"
    end
  end
  scenario 'Authenticated user try to delete other user answer' do
    sign_in(user)
    visit question_path(question)

    within "#answer_#{answer.id}" do
      expect(page).to_not have_link('Delete answer')
    end
  end
end
