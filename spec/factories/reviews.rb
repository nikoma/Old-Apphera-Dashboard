require 'securerandom'

FactoryGirl.define do
  factory :review do
    organization_id 5 
    content_provider_id 12  #model has method that checks this id presence so either hard code it or pass id of content provider after creating it from factory
    rating 5
    reviewer_id 1
    review_provider_id SecureRandom.urlsafe_base64(10)     
    end
end