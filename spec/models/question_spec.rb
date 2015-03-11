require 'rails_helper'

RSpec.describe Question, type: :model do

  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many :answers }

  it 'should delete dependent answers' do
      q  = FactoryGirl.create(:question)
      a1 = FactoryGirl.create(:answer, question_id: q.id)
      a2 = FactoryGirl.create(:answer, question_id: q.id)
      a3 = FactoryGirl.create(:answer, question_id: q.id)
      expect { q.destroy }.to change { Answer.count }.by(-3)
  end

end
