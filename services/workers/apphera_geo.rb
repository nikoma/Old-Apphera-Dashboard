$LOAD_PATH.unshift File.dirname(__FILE__)
require_relative  '../provider'
include Provider
require 'geocoder'
require_relative 'settings'
require 'bunny'

class AppheraGeo
  include Settings
 # p "starting geo service..."
  b = Bunny.new(:host =>HOST, :user => USER, :pass => PASS)
  b.start
  EXCHANGE = b.exchange("")
  QUEUE = b.queue("geo")
  loop do
  job = JSON.parse(QUEUE.pop[:payload])  rescue nil
  if job
    @org_id = job["org_id"]
      org = Organization.find(@org_id)
        geo = Geocoder.search("#{org.street}, #{org.city}, Germany")
        lat = 0
        long = 0
        begin
       # geo = Geocoder.search("Saseler Chaussee 254,hamburg,Germany")
         latlong = geo[0].data["geometry"].first[1]
        # coord = latlong["northeast"]
        rescue => e
         @logger.info("Geo crash caused by : " + e.inspect)
        end
         lat = latlong["lat"]
         long =  latlong["lng"]
        p "lat =  #{lat.to_s}"
        p "long =  #{long.to_s}"
        org.latitude = lat.to_f
        org.longitude = long.to_f
        org.save
      end
    sleep 3
  end
end
