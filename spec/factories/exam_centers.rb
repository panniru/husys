# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exam_center do
    center_name "MyString"
    address_line1 "MyString"
    address_line2 "MyString"
    city "MyString"
    state "MyString"
    country "MyString"
    pin "MyString"
    center_email "MyString"
    latitude 1.5
    longitude 1.5
  end
end
