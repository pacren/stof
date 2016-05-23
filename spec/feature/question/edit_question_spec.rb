require_relative '../feature_helper'

feature 'Question editing' do
  given(:user) { create(:user)  }
  given!(:question) { create(:question, user: user) }
  given!(:others_question) { create(:question) }

  scenario 'Non-authenticated user try to edit question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit question'
  end

  describe 'Authenticated user ' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'try to edit his question' do
      click_on 'Edit question'
      fill_in 'Title', with: 'New question title'
      fill_in 'Body', with: 'New question body'
      click_on 'Save'

      expect(page).to have_content 'New question title'
      expect(page).to have_content 'New question body'
    end

    scenario "try to update with blank fields" do
      click_on 'Edit question'
      fill_in 'Title', with: ''
      fill_in 'Body', with: ''
      click_on 'Save'

      expect(page).to have_content "too short"
    end

    scenario "try to edit other user's question" do
      visit question_path(others_question)

      expect(page).to_not have_link 'Edit question'
    end
  end
end
