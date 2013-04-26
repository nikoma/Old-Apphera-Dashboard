FactoryGirl.define do
  factory :organization do
    name Faker::Company.name
    street Faker::Address.street_name
    postalcode Faker::Address.postcode
    city Faker::Address.city
    state Faker::Address.state
    phone1 Faker::PhoneNumber.phone_number
    account_id  218
    facebook  ""
    twitter   ""
    latitude  Faker::Address.latitude
    longitude Faker::Address.longitude
    category_id 135
    country_code_id  228    
    end
end