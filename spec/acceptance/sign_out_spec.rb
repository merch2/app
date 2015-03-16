require 'rails_helper'

feature 'Sign Out', %q{
 Выход из системы Sign out
} do

  given(:user) { create(:user) }

  scenario 'Залогиненый юзер может выйти из системы' do
    visit new_user_session_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    click_on 'log out'
    expect(page).to have_content 'Signed out successfully'
  end


end