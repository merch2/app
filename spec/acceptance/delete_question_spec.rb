require 'rails_helper'

feature 'Delete Question' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Залогиненый юзер удаляет вопрос' do
    visit new_user_session_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit root_path
    click_on 'add question'
    fill_in 'title', with: 'Test Question'
    fill_in 'body',  with: 'Test Body'
    click_on 'Create Question'

    click_on 'Удалить вопрос'
    expect(current_path).to eq root_path
  end

  scenario 'Гость удаляет вопрос' do
    visit question_path(question)
    click_on 'Удалить вопрос'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'Залогиненый юзер удаляет не свой вопрос' do
    visit new_user_session_path
    fill_in 'Email',    with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    visit question_path(question)
    click_on 'Удалить вопрос'
    expect(page).to have_content 'Вы не автор вопроса'
  end


end