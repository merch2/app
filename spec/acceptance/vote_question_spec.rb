require_relative 'acceptance_helper'

feature 'Vote for question' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Guest try vote' do
    visit question_path(question)

    expect(page).to_not have_link '+'
  end

  scenario 'Author try vote' do
    sign_in(user)
    question = create(:question, user: user)
    visit question_path(question)

    expect(page).to_not have_link '+'
  end

  scenario 'Auth user try vote', js: true do
    sign_in(user)
    visit question_path(question)
    click_on '+'

    expect(page).to have_link 'unvote'
  end

  scenario 'Auth user try vote twice', js: true do
    sign_in(user)
    visit question_path(question)
    click_on '+'

    expect(page).to_not have_link '+'
  end

  scenario 'Sum votes', js: true  do
    sign_in(user)
    visit question_path(question)
    click_on '+'

    expect(page).to have_content 'Суммарный рейтинг вопроса:1'
  end


end

