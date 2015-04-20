require_relative 'acceptance_helper'

feature 'Vote for answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Guest try vote' do
    create(:answer, question_id: question.id)
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link '+'
    end
  end

  scenario 'Author try vote' do
    sign_in(user)
    create(:answer, question_id: question.id, user: user)

    visit question_path(question)
    within '.answers' do
      expect(page).to_not have_link '+'
    end
  end

  scenario 'User try vote', js: true do
    sign_in(user)
    create(:answer, question: question)

    visit question_path(question)
    within '.answers' do
      click_on '+'
      expect(page).to     have_link 'unvote'
      expect(page).to_not have_link '+'
    end
  end

  scenario 'User try vote twice', js: true do
    sign_in(user)
    create(:answer, question: question)

    visit question_path(question)
    within '.answers' do
      click_on '+'
      expect(page).to_not have_link '+'
    end
  end

  scenario 'Sum votes', js: true  do
    sign_in(user)
    create(:answer, question_id: question.id)
    visit question_path(question)
    within '.answers' do
      click_on '+'
      expect(page).to have_content 'Суммарный рейтинг ответа:1'
    end
  end

end