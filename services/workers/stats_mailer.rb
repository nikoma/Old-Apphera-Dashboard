#!ruby19
# encoding: utf-8
require 'rubygems'
require_relative '../provider'
require 'degermatize'
require_relative 'settings'
require_relative 'alert_sms'

class StatsMailer
  loop do

    #org_count = Review.count
    #org_last = Organization.last
    #org_name = org_last.name
    #org_city = org_last.city
    #memory  = `free -t -m`
    #disk = `df -h`
    #mes = " #{org_count.to_s} companies. #{org_name} in #{org_city}"
    rev = Review.count
    mes = "Apphera - collected #{rev.to_s} reviews"
    AlertSms.new.send_message(mes)


    sleep 3600
  end
end



