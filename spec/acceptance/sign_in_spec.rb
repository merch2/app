require 'rails_helper'

feature 'Sign In' do

  given(:user) { create(:user) }

  scenario 'Previously registered user tries to log in' do
    sign_in(user)

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path

  end

  scenario 'A non-existent user tries to log in' do
    visit new_user_session_path
    fill_in 'Email',    with: 'user_not_registered@email.com'
    fill_in 'Password', with: '123456789'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password'
    expect(current_path).to eq new_user_session_path
  end

end
