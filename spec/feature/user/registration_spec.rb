require_relative '../feature_helper'

feature 'User registration' do
  given(:user) { build(:user) }
  given(:registered_user) { create(:user) }

  scenario 'with valid data' do
    visit new_user_registration_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Confirmation password', with: user.password_confirmation
    click_on 'Sign up'

    expect(current_path).to eq root_path
    expect(page).to have_content 'signed up successfully'
  end

  scenario 'with already registered email' do
    visit new_user_registration_path

    fill_in 'Email', with: registered_user.email
    fill_in 'Password', with: registered_user.password
    fill_in 'Confirmation password', with: registered_user.password_confirmation
    click_on 'Sign up'

    expect(current_path).to eq user_registration_path
    expect(page).to have_content "has already been taken"
  end
end
