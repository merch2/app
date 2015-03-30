FactoryGirl.define do
  factory :answer do
    body "MyText"
    trait :with_files
    transient do
      number_of_files 1
    end

    after(:create) do |answer, evaluator|
      create_list(:attachment, evaluator.number_of_files, attachmentable: answer)
    end
  end

  factory :invalid_answer, class: "Answer" do
    body "12"
  end

end
