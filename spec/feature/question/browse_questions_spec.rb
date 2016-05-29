require_relative '../feature_helper'

feature 'User can browsing all questuion' do
  given(:user) { create(:user)  }

  scenario 'Questions present' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Question text'
    click_on 'Create'
    visit questions_path

    expect(page).to have_content 'Test question'
  end

  scenario 'Questions no-present' do
    sign_in(user)
    visit questions_path
    expect(page).to have_content 'There are no questions.'
  end

  scenario 'Non-authenticated user browse render results' do
    visit questions_path
    expect(page).to have_content 'There are no questions.'
  end
end
