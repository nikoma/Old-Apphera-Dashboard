# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact do
    name "MyString"
    email "MyString"
    phone "MyString"
    city "MyString"
    country "MyString"
    subject "MyString"
    comment "MyText"
  end
end
