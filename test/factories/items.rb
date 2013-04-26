# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    subject "MyString"
    body "MyText"
    rating "9.99"
    type 1
    folder 1
    visible false
    source 1
    reminder "2013-02-17 10:13:48"
    new false
    organization_id 1
    reviewer_id 1
    completed false
  end
end
