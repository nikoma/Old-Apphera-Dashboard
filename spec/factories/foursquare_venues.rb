 
    
FactoryGirl.define do
  
  factory :foursquare_venue do
    foursquare_id SecureRandom.uuid
    name 'Test venue'
    phone Faker::PhoneNumber.phone_number
    category  "test"
    organization_id  SecureRandom.random_number(1000)
    top_category  "test"
    address  Faker::Address.building_number
    city     Faker::Address.city
    postalcode Faker::Address.postcode
    state   Faker::Address.state
    lat  Faker::Address.latitude
    lng   Faker::Address.longitude
  
  end

end
