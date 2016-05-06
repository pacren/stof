require 'rails_helper'

feature 'Create question' do
  given(:user) { create(:user)  }

  scenario 'Authenticated user creates question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Question text'
    click_on 'Create'

    expect(page).to have_content 'Your question suscefully created'
  end

  scenario 'Non authenticated user ties to create question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in'
  end
end
