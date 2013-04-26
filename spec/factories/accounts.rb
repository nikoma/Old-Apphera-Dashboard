FactoryGirl.define do
  factory :account do
    name Faker::Company.name
    firstname Faker::Name.first_name
    lastname Faker::Name.last_name
    phone Faker::PhoneNumber.phone_number
    account_type_id 22
    postalcode Faker::Address.postcode
    street Faker::Address.street_name
    street1 Faker::Address.street_address
    state Faker::Address.state
    city Faker::Address.city
    country_id 28
    
  end  
  
end



