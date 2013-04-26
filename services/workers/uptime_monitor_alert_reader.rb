#!ruby19
# encoding: utf-8
require 'rubygems'
require 'bunny'
require_relative '../provider'
require_relative 'settings'
require_relative 'alert_sms'



class UptimeMonitorAlertReader
  include Settings
  b = Bunny.new(:host => HOST, :user => USER, :pass => PASS)
  b.start

  q = b.queue("uptime_monitor_alert")
  ex = b.exchange("")

  loop do
    item = JSON.parse(q.pop[:payload]) rescue nil

    if item
      org_id = item["org_id"]
      message = item["message"]
      url = item["url"]
      AlertSms.new.send_message("Apphera Uptime monitor: #{org_id} url: #{url} -  #{message}")
      #Listing.create!(name: name, street: street, city: city, zip: zip, phone: phone, content_provider: content_provider, :organization_id => org_id)

    end
    sleep 1
  end

end

