# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :descriptive_question do
    course_id 1
    description "MyString"
    answer "MyString"
  end
end
