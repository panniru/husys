# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:user_id_sequence) { |n| "user#{n}" }

  factory :user, :class => User do
    user_id { Factory.next :user_id_sequence }
    email "srikanth@ostryaabs.com"
    password "welcome"
    association :role, :factory => :role
  end
end
