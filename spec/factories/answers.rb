FactoryGirl.define do
  factory :answer do
    body 'MyString'
    question
    user
  end

  factory :invalid_answer, class: 'Answer' do
    body nil
  end
end
