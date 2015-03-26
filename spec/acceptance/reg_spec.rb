require_relative 'acceptance_helper'

feature 'Registration' do

  scenario 'Successful Registration' do
    visit new_user_registration_path
    fill_in 'Email',    with: 'test@email.com'
    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with: '123456789'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully'
  end

  scenario 'Unsuccessful Registration. Password does not equal Confirm Password' do
    visit new_user_registration_path
    fill_in 'Email',    with: 'test@email.com'
    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with: '1234567890'
    click_on 'Sign up'

    expect(page).to have_content 'Password confirmation doesn\'t match Password'
  end

  scenario 'Unsuccessful Registration. Email has already been taken' do
    User.create!(email: 'user@email.com', password: '123456789')
    visit new_user_registration_path
    fill_in 'Email',    with: 'user@email.com'
    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with: '123456789'
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'Unsuccessful Registration. Password bad validate' do
    visit new_user_registration_path
    fill_in 'Email',    with: 'user@email.com'
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: '123'
    click_on 'Sign up'

    expect(page).to have_content 'Password is too short'
  end

end
