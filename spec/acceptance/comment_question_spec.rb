require_relative 'acceptance_helper'

feature 'Comment Question' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Guest try comment question' do
    visit question_path(question)

    expect(page).to_not have_button 'Create Comment'
  end

  scenario 'Auth user can try comment question', js: true do
    sign_in(user)
    visit question_path(question)
    fill_in 'comment_body', with: 'test comment'
    click_on 'Create Comment'
    within '.question_comments' do
      expect(page).to have_content 'test comment'
    end
  end

end