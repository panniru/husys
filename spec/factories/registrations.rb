# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registration do
    student_id 1
    exam_center_id 1
    machine_id 1
    course_id 1
    exam_date "2014-02-03"
    exam_start_time "2014-02-03 10:32:16"
    exam_end_time "2014-02-03 10:32:16"
    registration_date "2014-02-03"
    no_of_attempts 1
  end
end
