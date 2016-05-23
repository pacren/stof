require_relative '../feature_helper'

feature 'Show question' do
  given(:user){create :user}
  given!(:question) {create :question, user_id: user, title: 'Title1'}

  scenario 'authenticated user' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_content 'Title1'
  end

  scenario 'non-authenticated user' do
    visit question_path(question)

    expect(page).to have_content 'Title1'
  end
end
