require 'rails_helper'

feature 'Sign In', %q{
  Чтобы задавать вопросы, пользователь должен залогиниться
  Пользователь должен иметь возможность sign in
} do

  given(:user) { create(:user) }

  scenario 'Ранее регистрированный пользователь пытается войти' do
    visit new_user_session_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path

  end

  scenario 'Несуществующий пользователь пытается войти' do
    visit new_user_session_path
    fill_in 'Email',    with: 'user_not_registered@email.com'
    fill_in 'Password', with: '123456789'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password'
    expect(current_path).to eq new_user_session_path
  end

end
