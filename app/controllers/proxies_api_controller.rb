class ProxiesApiController < ApplicationController

  before_filter :basic_auth

  def index
    #proxy = Proxy.where(tested: true, bad:false).random
    proxy = Proxy.where(bad: false).random
    @ip = proxy.ip
    @port = proxy.port.to_i
    json = {"ip" => @ip, "port" => @port, "proxy_id" => proxy.id}.to_json
    render json: json
  end
end


#class AppheraApi
#  include HTTParty
#  base_uri 'https://dashboard.apphera.com'
#  basic_auth 'crawler', 'hallocrawler12345!'
#end

#class AppheraApi2
#  include HTTParty
#  base_uri '127.0.0.1:3000'
#  basic_auth 'crawler', 'hallocrawler12345!'
#end