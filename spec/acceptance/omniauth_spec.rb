require_relative 'acceptance_helper'

feature 'Omniauth' do

  scenario 'sign in with facebook' do
    OmniAuth.config.test_mode = true
    visit root_path
    click_on 'log in'
    mock_auth_hash(:facebook, '123@123.com')
    click_on 'Sign in with Facebook'


    expect(page).to have_content 'Successfully authenticated from Facebook account'
  end

  scenario 'sign in with twitter' do
    OmniAuth.config.test_mode = true
    visit root_path
    click_on 'log in'
    mock_auth_hash(:twitter)
    click_on 'Sign in with Twitter'

    expect(page).to have_content 'Please fill form'
    fill_in 'auth_info_email', with: 'test@email.com'
    click_on 'Save'

    expect(page).to have_content 'Successfully authenticated from Twitter account'
  end



end