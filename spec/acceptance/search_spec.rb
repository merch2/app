require_relative 'acceptance_helper'

feature 'Search' do

  given!(:question) { create :question, title: 'title', body: 'body' }
  given!(:question2) { create :question, title: 'question2', body: 'nil' }
  given!(:comment) { create :comment, commentable_id: question2.id, commentable_type: 'Question', body: 'title' }

  scenario 'search all', js: true do
    ThinkingSphinx::Test.run do
      visit root_path

      fill_in 'q', with: 'title'
      click_on 'search'
      save_and_open_page

      expect(page).to have_content('question -title')
      expect(page).to have_content('comment -title')
    end
  end

  scenario 'search with condition', js: true do
    ThinkingSphinx::Test.run do
      visit root_path

      select('comments', from: 'condition')
      fill_in 'q', with: 'title'
      click_on 'search'

      expect(page).to have_content('comment -title')
      expect(page).to_not have_content('question -title')
    end
  end

end