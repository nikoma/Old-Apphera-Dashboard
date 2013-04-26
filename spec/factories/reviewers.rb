FactoryGirl.define do
  factory :reviewer do
    
    
    name Faker::Name.name
    slug { Faker::Internet.url }
    content_provider_id 12
    
    end
end