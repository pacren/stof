require 'rails_helper'

feature 'User sign in' do

  given(:user) { create(:user)  }

  scenario 'Registered user try to sign in' do
    sign_in(user)

    expect(page).to have_content 'Signed in'
  end

  scenario 'Non-registered user try to sign in' do
    visit new_user_session_path

    fill_in 'Email', with: 'non@example.com'
    fill_in 'Password', with: '12345678'
    click_button 'Log in'

    expect(page).to have_content 'Invalid Email or password'
  end
end
