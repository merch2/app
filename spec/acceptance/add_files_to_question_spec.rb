require_relative 'acceptance_helper'

feature 'Add files to question' do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

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

  scenario 'User add multiple files when create question', js: true do
    fill_in 'title', with: 'Test Question'
    fill_in 'body',  with: 'Test Body'
    click_on 'Add more'
    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
    inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
    click_on 'Create Question'

    expect(page).to have_link 'spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb'
  end

  scenario 'EDIT QUESTION: attach 2 files', js: true do
    visit question_path(question)
    click_on 'Редактировать вопрос'
    click_on 'Add file'
    click_on 'Add file'
    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
    inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
    click_on 'Update Question'


    expect(page).to have_link 'spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb'
  end

  scenario 'EDIT QUESTION: delete attach files', js:true do
    create(:question, :with_files, number_of_files: 1)
    visit edit_question_path(question)
    click_on 'Del file'

    expect(page).to_not have_link 'spec_helper.rb'
  end

end