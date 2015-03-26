require_relative 'acceptance_helper'

feature 'Edit Answer' do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Guest try edit answer' do
    create(:answer, question: question)
    visit question_path(question)
    expect(page).to_not have_link 'Редактировать'
  end

  scenario 'Auth user try edit other user answer' do
    create(:answer, question: question)
    sign_in(user)
    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link 'Редактировать'
    end
  end

  scenario 'Auth and author try edit answer', js: true do
    create(:answer, question: question, user: user)

    sign_in(user)
    visit question_path(question)
    click_on 'Редактировать'
    within '.answers' do
      fill_in 'answer_body', with: 'test answer'
      click_on 'Save'
      expect(page).to have_content 'test answer'
      expect(page).to_not have_select 'textarea'
    end
  end

end