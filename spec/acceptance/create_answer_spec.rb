require 'rails_helper'

feature 'Create Answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Auth user create answer' do
    sign_in(user)
    visit question_path(question)

    click_on 'Ответить'
    fill_in 'body', with: 'Test Answer'
    save_and_open_page
    click_on 'Create Answer'
    expect(page).to have_content 'Test Answer'

  end

  scenario 'Guest create answer' do
    visit question_path(question)
    click_on 'Ответить'
    expect(current_path).to eq new_user_session_path
  end

end