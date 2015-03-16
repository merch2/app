require 'rails_helper'

feature 'Delete Answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Юзер удаляет свой ответ' do
    visit new_user_session_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit question_path(question)
    click_on 'Ответить'
    fill_in 'body',  with: 'Test Answer'
    click_on 'Create Answer'
    click_on 'Удалить ответ'

    expect(page).to have_content 'Ответ удален'

  end

end