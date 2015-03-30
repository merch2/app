FactoryGirl.define do
  factory :question do
    title "MyString"
    body "MyText"
    trait :with_files
    transient do
      number_of_files 1
    end

    after(:create) do |question, evaluator|
      create_list(:attachment, evaluator.number_of_files, attachmentable: question)
    end

  end

  factory :invalid_question, class: "Question" do
    title nil
    body  nil
  end


end
