require 'rails_helper'

feature 'Create Answer' do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

  scenario 'Auth user create answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'answer_body', with: 'Test Answer'
    click_on 'Create Answer'

    expect(current_path).to eq question_path(question)
    within '.answers' do
      expect(page).to have_content 'Test Answer'
    end
  end

  scenario 'Guest create answer', js: true do
    visit question_path(question)

    expect(page).to have_content 'Login'
  end

end