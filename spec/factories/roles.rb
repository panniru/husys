# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :role do
    role "admin"
    code "admin"
    description "admin"
  end
end
