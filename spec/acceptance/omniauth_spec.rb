require_relative 'acceptance_helper'

feature 'Omniauth' do

  scenario 'sign in with twitter' do
    OmniAuth.config.test_mode = true
    visit root_path
    click_on 'log in'
    click_on 'Sign in with Twitter'
    mock_auth_hash(:twitter)
    expect(page).to have_content 'Please fill form'
    fill_in 'auth_info_email', with: 'test@email.com'
    click_on 'Save'

    expect(page).to have_content 'Successfully authenticated from Twitter account'
  end

  scenario 'sign in with facebook' do
    OmniAuth.config.test_mode = true
    visit 'http://localhost:3000'
    click_on 'log in'
    click_on 'Sign in with Facebook'
    save_and_open_page
    mock_auth_hash(:facebook)

    expect(page).to have_content 'Successfully authenticated from Facebook account'
  end

end