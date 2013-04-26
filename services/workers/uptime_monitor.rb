require 'open-uri'
require 'date'
require_relative 'settings'
require 'bunny'
require 'json'


class UptimeMontitor
  include Settings
  b = Bunny.new(:host => HOST, :user => USER, :pass => PASS)
  b.start
  EXCHANGE = b.exchange("")
  QUEUE = b.queue("uptime_monitor")
  loop do
    job = JSON.parse(QUEUE.pop[:payload]) rescue nil
    if job
      @org_id = job["org_id"]
      @url = job["url"]
      reg = /http:\/\/|https:\/\//
      unless @url =~ reg
        @url = "http://"+@url
      end

      @magic_word = job["magic_word"]

      url = @url
      start = Time.new
      begin
        f = open(url).read
      rescue => e
        er = "error: " + e.inspect
        json = {"org_id" => @org_id, "url" => @url ,"message" => er}.to_json
        json2 = {"organization_id" => @org_id, "url" => @url, "load_time" => 99, "time_stamp" => DateTime.now}.to_json
        EXCHANGE.publish(json, :key => "uptime_monitor_alert")
        EXCHANGE.publish(json2, :key => "uptime_monitor_results")
        next
      end

      stop = Time.new
      json2 = {"organization_id" => @org_id, "url" => @url, "load_time" => stop - start, "time_stamp" => DateTime.now}.to_json
      EXCHANGE.publish(json, :key => "uptime_monitor_results")

    #  puts "Time elapsed: #{stop - start} seconds"
      #puts "The content of the file is:\n#{f}"
    end
   # puts "nothing"
    sleep 0.2
  end


end