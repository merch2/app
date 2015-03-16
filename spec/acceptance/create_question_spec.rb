require 'rails_helper'

feature 'Create Question' do

  given(:user) { create(:user) }

  scenario 'Залогиненый пользователь создает вопрос' do
    visit new_user_session_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit root_path
    click_on 'add question'
    fill_in 'title', with: 'Test Question'
    fill_in 'body',  with: 'Test Body'
    click_on 'Create Question'

    expect(page).to have_content 'Test Question'
  end

  scenario 'Не залогиненый пользователь создает вопрос' do
    visit root_path
    click_on 'add question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end