require_relative 'acceptance_helper'

feature 'Delete Question' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Auth user delete question' do
    sign_in(user)
    question = create(:question, user: user)
    visit question_path(question)
    expect(page).to have_content 'Удалить вопрос'
  end



  scenario 'Guest user delete question' do
    visit question_path(question)
    expect(page).to_not have_content 'Удалить вопрос'
  end

  scenario 'Auth user delete not your question' do
    sign_in(user)
    visit question_path(question)
    expect(page).to_not have_content 'Удалить вопрос'
  end


end