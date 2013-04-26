require 'httparty'

class AppheraApi
  include HTTParty

  # TODO: credentials
  def proxy
    auth = {:username => "", :password => ""}
    options = {:basic_auth => auth}
    base_uri = 'https://dashboard.apphera.com/ProxiesApi'
    response = HTTParty.get(base_uri, options)
    response.body
  end
end
