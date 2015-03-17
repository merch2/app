require 'rails_helper'

feature 'Delete Answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer) }

  scenario 'User delete answer' do
    sign_in(user)

    visit question_path(question)
    click_on 'Ответить'
    fill_in 'body',  with: 'Test Answer'
    click_on 'Create Answer'
    click_on 'Удалить ответ'

    expect(page).to have_content 'Ответ удален'

  end

  scenario 'Delete someone else\'s answer' do
    sign_in(user)
    visit question_path(question)
    click_on 'Удалить ответ'

    expect(page).to have_content 'Вы не автор ответа'
  end

end