# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :machine_id do |n|
    "M-#{n}"
  end
  factory :machine do
    machine_id
    exam_center_id 1
    status "Active"
  end
end
