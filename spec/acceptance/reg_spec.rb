require 'rails_helper'

feature 'Registration', %q{
  Регистрация в системе
} do

  scenario 'Удачная регистрация' do
    visit new_user_registration_path
    fill_in 'Email',    with: 'test@email.com'
    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with: '123456789'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully'
  end

  scenario 'Неудачная регистрация. Не совпал пароль и повторение пароля' do
    visit new_user_registration_path
    fill_in 'Email',    with: 'test@email.com'
    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with: '1234567890'
    click_on 'Sign up'

    expect(page).to have_content 'Password confirmation doesn\'t match Password'
  end

  scenario 'Неудачная регистрация. Такой емаил уже есть в системе' do
    User.create!(email: 'user@email.com', password: '123456789')
    visit new_user_registration_path
    fill_in 'Email',    with: 'user@email.com'
    fill_in 'Password', with: '123456789'
    fill_in 'Password confirmation', with: '123456789'
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end

  scenario 'Неудачная регистрация. Пароль не прошел валидацию' do
    visit new_user_registration_path
    fill_in 'Email',    with: 'user@email.com'
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: '123'
    click_on 'Sign up'

    expect(page).to have_content 'Password is too short'
  end

end
