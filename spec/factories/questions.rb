# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question do
    exam_id 1
    description "MyString"
    answer_1 "MyString"
    answer_2 "MyString"
    answer_3 "MyString"
    answer_4 "MyString"
    correct_answer "MyString"
  end
end
