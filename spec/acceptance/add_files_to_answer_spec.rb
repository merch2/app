require_relative 'acceptance_helper'

feature 'Add files to new answer' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, user:user, question: question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'User add file when create answer', js: true do
    fill_in 'Your answer',  with: 'Test Answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create Answer'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/2/spec_helper.rb'
    end
  end

  scenario 'User add multiple files when create answer', js: true do
    fill_in 'Your answer',  with: 'Test Answer'
    click_on 'Add more'
    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
    inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
    click_on 'Create Answer'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb'
    end
  end

  scenario 'EDIT ANSWER: attach files', js: true do

    click_on 'Редактировать'
    click_on 'Add file'
    click_on 'Add file'
    inputs = all('input[type="file"]')
    inputs[0].set("#{Rails.root}/spec/spec_helper.rb")
    inputs[1].set("#{Rails.root}/spec/rails_helper.rb")
    click_on 'Save'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb'
      expect(page).to have_link 'rails_helper.rb'
    end
  end

  scenario 'EDIT ANSWER: delete files', js: true do
    create(:answer, :with_files, number_of_files: 1, question: question)
    click_on 'Редактировать'
    click_on 'Del file'

    within '.answers' do
      expect(page).to_not have_link 'spec_helper.rb'
    end
  end

end