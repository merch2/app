require 'rails_helper'

feature 'Create Answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Залогиненый юзер создает ответ' do

    visit new_user_session_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit question_path(question)

    click_on 'Ответить'
    fill_in 'body', with: 'Test Answer'
    expect(page).to have_content 'Test Answer'

  end

  scenario 'Гость создает ответ' do
    visit question_path(question)
    click_on 'Ответить'
    expect(current_path).to eq new_user_session_path
  end

end