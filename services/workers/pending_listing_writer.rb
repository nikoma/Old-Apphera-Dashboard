#!ruby19
# encoding: utf-8
require 'rubygems'
require 'bunny'
require_relative '../provider'
require 'degermatize'
require_relative 'settings'


class PendingListingWriter
  include Settings
  b = Bunny.new(:host => HOST, :user => USER, :pass => PASS)
  b.start

  q = b.queue("company_listings")
  ex = b.exchange("")

  loop do
    item = JSON.parse(q.pop[:payload]) rescue nil

    if item
      name = item["name"]
      phone = item["phone"] || ""
      street = item["street"] || ""
      zip = item["zip"] || ""
      city = item["city"] || ""
      org_id = item["org_id"].to_i
      category = item["category"] || ""
      content_provider = item["content_provider"]
      Listing.create!(name: name, street: street, city: city, zip: zip, phone: phone, content_provider: content_provider, :organization_id => org_id)
    end
    sleep 1
  end

end

