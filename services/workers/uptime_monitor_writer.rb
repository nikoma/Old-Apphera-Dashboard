#!ruby19
# encoding: utf-8
require 'rubygems'
require 'bunny'
require_relative '../provider'
require_relative 'settings'


class UptimeMonitorWriter
  include Settings
  b = Bunny.new(:host => HOST, :user => USER, :pass => PASS)
  b.start

  q = b.queue("uptime_monitor_results")
  ex = b.exchange("")

  loop do
    item = JSON.parse(q.pop[:payload]) rescue nil

    if item
      organization_id = item["organization_id"]
      load_time = item["load_time"]
      time_stamp = item["time_stamp"]
      url = item["url"]
      UptimeMonitor.create!(organization_id: organization_id, url: url, load_time: load_time, time_stamp: time_stamp)
    end
    sleep 1
  end

end

