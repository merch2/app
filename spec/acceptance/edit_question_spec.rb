require_relative 'acceptance_helper'

feature 'Edit Question' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Guest try edit question' do
    visit question_path(question)
    expect(page).to_not have_link 'Редактировать вопрос'
  end

  scenario 'Author try edit question' do
    question = create(:question, user: user)
    sign_in(user)
    visit question_path(question)

    click_on 'Редактировать вопрос'
    fill_in 'question_title', with: 'New Title'
    fill_in 'question_body',  with: 'New Body'
    click_on 'Update Question'

    expect(page).to_not have_content question.body
    expect(page).to have_content 'New Title'
    expect(page).to have_content 'New Body'
  end

  scenario 'User try edit others user question' do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_link 'Редактировать вопрос'
  end
end