# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:question_id_sequence) { |n| "#{n}" }
  factory :question do
    exam_id { Factory.next :question_id_sequence }
    description "Question1"
    option_1 "answer1"
    option_2 "answer2"
    option_3 "answer3"
    option_4 "answer4"
    answer "answer1"
  end
end
