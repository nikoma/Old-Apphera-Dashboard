class CompSearch
  include Sidekiq::Worker

  def perform(org)
    #!ruby19
    # encoding: utf-8
    
    require 'httparty'
    @org = Organization.find org
    base_uri =  "https://api.apphera.com/api/v1/geocomps?cat=1144&token=k5w4aQVp2H2qigKnXBzs&lat=#{@org.latitude}&#{@org.longitude}"
    response = HTTParty.get(base_uri)
    comps = JSON.parse(response.body)
    comps.each do |c|
      name = c["organization"]["name"]
      street = c["organization"]["street"]
      city = c["organization"]["city"]
      state = c["organization"]["state"]
      url = c["organization"]["url"]
      latitude = c["organization"]["latitude"].to_f
      longitude = c["organization"]["longitude"].to_f
      postalcode = c["organization"]["postalcode"]
      phone1 =  c["organization"]["phone1"]
      organization_id = c["organization"]["organization_id"]
      yahoo_slug = SecureRandom.uuid
      @comp = Organization.create!(name: name, street: street, city: city, url: url,latitude: latitude, longitude: longitude, postalcode: postalcode, phone1: phone1, id: organization_id, yahoo_slug: yahoo_slug )
      @org.organization << @comp
      @org.save
      BingApi.perform_async(@org.id)
    end

  end
end
