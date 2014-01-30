# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exam_centers do
    center_name "Head Office"
    address_line1 "IIIT"
    address_line2 "Gachibowli"
    city "Hyderabad"
    state "AndhraPradesh"
    country "India"
    pin "500056"
    center_email "iiit@gmail.com"
  end
end
