require_relative '../feature_helper'

feature 'Create answer' do
  given (:user) { create :user }
  given (:question) { create :question }

  scenario 'Authenticated user create answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'Answer text'
    click_on 'Create answer'

    expect(current_path).to eq question_path(question)
    expect(page).to have_content 'Answer text'
  end

  scenario 'Non authenticated user ties to create answer' do
    visit question_path(question)

    expect(page).to_not have_content 'Your answer'
  end
end
