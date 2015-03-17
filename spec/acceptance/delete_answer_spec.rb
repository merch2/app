require 'rails_helper'

feature 'Delete Answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer) }

  scenario 'User delete answer' do
    sign_in(user)
    create(:answer, question: question, user: user)
    visit question_path(question)
    expect(page).to have_content 'Удалить ответ'
  end

  scenario 'Delete someone else\'s answer' do
    sign_in(user)
    visit question_path(question)
    expect(page).to_not have_content 'Удалить ответ'
  end

  scenario 'Guest delete answer' do
    visit question_path(question)
    expect(page).to_not have_content 'Удалить ответ'
  end

end