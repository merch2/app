require_relative 'acceptance_helper'

feature 'Search' do

  given!(:question) { create :question, title: 'title' }

  scenario 'search all' do
    ThinkingSphinx::Test.run do
      visit root_path

      fill_in 'q', with: 'title'
      click_on 'search'

      expect(page).to have_link('title')
    end
  end

end