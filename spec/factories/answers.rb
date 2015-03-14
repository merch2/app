FactoryGirl.define do
  factory :answer do
    body "MyText"
  end

  factory :invalid_answer, class: "Answer" do
    body "12"
  end

end
