# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :result do
    registration_id 1
    total_marks 1
    marks_secured 1.5
    exam_result "MyString"
    pass_test "MyString"
  end
end
