require 'rails_helper'

feature 'Question delete' do
  given(:user) { create(:user)  }
  given!(:question) { create(:question, user: user) }
  given!(:others_question) { create(:question) }

  scenario 'Non-authenticated user try to delete question' do
    visit question_path(question)

    expect(page).to_not have_link 'Delete question'
  end

  describe 'Authenticated user ' do
    before do
      sign_in user
      visit question_path(question)
    end

    scenario 'try to delete his question' do
      click_on 'Delete question'

      expect(page).to have_content 'Your question deleted'
    end

    scenario "try to edit other user's question" do
      visit question_path(others_question)

      expect(page).to_not have_link 'Delete question'
    end
  end
end
