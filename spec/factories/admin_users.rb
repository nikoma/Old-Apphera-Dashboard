# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin_user do
     after(:create) {|user| user.add_role(:admin)}
  end
end
