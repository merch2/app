require_relative 'acceptance_helper'

feature 'Create Question' do

  given(:user) { create(:user) }

  scenario 'Auth user create question' do
    sign_in(user)

    visit root_path
    click_on 'add question'
    fill_in 'title', with: 'Test Question'
    fill_in 'body',  with: 'Test Body'
    click_on 'Create Question'

    expect(page).to have_content 'Test Question'
  end

  scenario 'Guest create question' do
    visit root_path
    click_on 'add question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end