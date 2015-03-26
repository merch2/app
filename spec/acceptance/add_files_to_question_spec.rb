require_relative 'acceptance_helper'

feature 'Add files to question' do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User add file when create question' do
    fill_in 'title', with: 'Test Question'
    fill_in 'body',  with: 'Test Body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create Question'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

end