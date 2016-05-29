require_relative '../feature_helper'

feature 'Answer editing' do
  given (:autor) { create :user }
  given (:user) { create :user }
  given (:question) { create :question }
  given! (:answer) { create :answer, question: question, user: autor }

  scenario 'Non-authenticated user try edit answer' do
    visit question_path(question)

    within '.answer__box' do
      expect(page).to_not have_link('Edit answer')
    end
  end

  scenario 'User edit his answer', js: true do
    sign_in(autor)
    visit question_path(question)

    within "#answer_#{answer.id}" do
      click_on 'Edit answer'
      fill_in 'Your answer', with: "New answer text #{answer.id}"
      click_on 'Save'
    end
    
    expect(page).to have_content("New answer text #{answer.id}")
  end

  scenario 'Authenticated user try to edit other user answer', js: true do
    sign_in(user)
    visit question_path(question)

    within "#answer_#{answer.id}" do
      expect(page).to_not have_link('Edit answer')
    end
  end
end
