#!ruby19
# encoding: utf-8
require 'rubygems'
require 'bunny'
require_relative '../provider'
require 'degermatize'
require_relative 'settings'

#TODO: use apphera API instead?

class PendingCompetitorsWriter
  include Settings
  b = Bunny.new(:host => HOST, :user => USER, :pass => PASS)
  b.start

  q = b.queue("pending_competitors")
  ex = b.exchange("")

  loop do
  item = JSON.parse(q.pop[:payload]) rescue nil

  if item          
    name = item["name"]
    phone = item["phone"]
    street = item["street"]
    zip = item["zip"]
    city = item["city"]
    latitude = item["latitude"].to_f
    longitude = item["longitude"].to_f
    website = item["website"]
    category_id = item["category_id"]
    #rating = item["rating"] rescue nil
    searched_for_org_id = item["org_id"] || 1
    yahooslug = item["review_url"]
    @organization = Organization.find(searched_for_org_id)
    begin
    @org = Organization.create!(category_id: category_id, name: name, street: street, yahooslug: yahooslug, city: city, postalcode: zip, latitude: latitude, longitude: longitude, url: website, phone1: phone)
    rescue
      puts "DOUBLE DETECTED! #{name}"
      end
    if @org
      unless @organization.id == 1
    @organization.organizations << @org unless @organization.organizations.exists?(@org)
        end
      end
  end
  #p "loop"
    sleep 2
  end

end

