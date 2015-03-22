require_relative 'acceptance_helper'

feature 'Sign Out' do

  given(:user) { create(:user) }

  scenario 'Logged user can log out' do
    sign_in(user)
    click_on 'log out'
    expect(page).to have_content 'Signed out successfully'
  end


end