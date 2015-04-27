require_relative 'acceptance_helper'

feature 'Comment Answer' do
  given(:user)     { create(:user) }
  given(:question) { create(:question) }
  given!(:answer)   { create(:answer, question: question) }

  scenario 'Guest try comment answer' do
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_button 'Create Comment'
    end
  end

  scenario 'Auth user can try comment answer', js: true do
    sign_in(user)
    visit question_path(question)
    within '.answers' do
      fill_in 'comment_body', with: 'test comment'
      click_on 'Create Comment'
      expect(page).to have_content 'test comment'
      save_and_open_page
    end
  end

end