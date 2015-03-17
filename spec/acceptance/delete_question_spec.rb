require 'rails_helper'

feature 'Delete Question' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Auth user delete question' do
    sign_in(user)

    visit root_path
    click_on 'add question'
    fill_in 'title', with: 'Test Question'
    fill_in 'body',  with: 'Test Body'
    click_on 'Create Question'

    click_on 'Удалить вопрос'
    expect(current_path).to eq root_path
  end



  scenario 'Guest user delete question' do
    visit question_path(question)
    click_on 'Удалить вопрос'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'Auth user delete not your question' do
    sign_in(user)

    visit question_path(question)
    click_on 'Удалить вопрос'
    expect(page).to have_content 'Вы не автор вопроса'
  end


end