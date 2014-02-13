# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    course_id "MyString"
    course_name "MyString"
    category "MyString"
    sub_course "MyString"
    exam_name "MyString"
    duration 10
    no_of_questions 5
  end
end
