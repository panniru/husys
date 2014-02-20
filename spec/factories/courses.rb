# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :course do
    category "Sample Category"
    sub_category "Sample Sub Category"
    course_name "Sample Course"
    exam_name "Sample Exam"
    duration 1.00
    no_of_questions 10
    pass_criteria_1 85
    pass_text_1 "Distinction"
    pass_criteria_2 75
    pass_text_2 "First Division"
    pass_criteria_3 60
    pass_text_3 "Secound Division"
    pass_criteria_4 40
    pass_text_4 "Passed"
  end
end
