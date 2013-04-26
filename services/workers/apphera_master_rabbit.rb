#!ruby19
# encoding: utf-8

require 'rubygems'
require_relative 'settings'
require 'bunny'
require_relative '../provider'
require 'degermatize'
require 'open-uri'

class AppheraMaster
  include Settings
  @cp = {:google_germany => 8, :kennstdueinen => 12, :tripadvisor => 7, :bing => 6, :pointoo => 13, :qype => 10, :golocal => 14, :hotels => 15, :meinestadt => 16, :restaurantkritik => 17, :wowarstdu => 18, :yahoo => 32, :urbanspoon =>3, :yellowpages => 4, :yelp => 5, :cars => 19, :superpages => 20, :zillow => 21, :resellerrating => 22, :kudzu => 23, :merchantcircle => 24, :insiderpages => 25, :zocdoc => 26 }
  @cp_urls = {:kennstdueinen => "kennstdueinen.de", :tripadvisor => "tripadvisor.com", :pointoo => "pointoo.de", :qype => "qype.com", :golocal => "golocal.com", :hotels => "hotels.com", :meinestadt => "meinestadt.de",:yahoo => "local.yahoo.com", :restaurantkritik => "restaurant-kritik.de", :wowarstdu => "wowarstdu.de", :urbanspoon => "urbanspoon.com", :yellowpages => "yellowpages.com", :yelp => "yelp.com", :cars => "cars.com", :superpages => "superpages.com", :zillow => "zillow.com", :resellerrating => "resellerrating.com", :kudzu => "kudzu.com", :merchantcircle => "merchantcircle.com", :insiderpages => "insiderpages.com", :zocdoc => "zocdoc.com"}
  @review_providers = %w[qype kennstdueinen tripadvisor pointoo golocal hotels meinestadt restaurantkritik wowarstdu yahoo urbanspoon yellowpages yelp cars superpages zillow resellerrating kudzu merchantcircle insiderpages zocdoc]
  @search_providers = %w[google_germany bing]
  b = Bunny.new(:user => USER, :pass => PASS, :host => HOST)
  b.start
  q = b.queue("crawlers")
  exchange = b.exchange("", :durable => true)
# crawler methods
  loop do
    schedules = Schedule.where("scheduled < ?", DateTime.now).where(:in_progress => false).limit(100) # TODO: toggle by environment like a few in development or just get development queues and everything
    schedules_count = schedules.count
    a = 0
    schedules.each do |schedule|
      schedule.in_progress = true
      schedule.save
      schedules_count = schedules_count - 1
      @org = Organization.find(schedule.organization_id)
      @sequence = schedule.sequence
      @items = @sequence.sequence_items.to_a

      unless @items.nil?
        @items.each do |item|
          @ranktrigger = 0
          item_name = item.name #"CompetitorsGermany"#
          puts item_name
          case item_name
            when "GoogleSlug"
              search_string = @org.name + ", " + @org.street + ", " + @org.city
              @cp_urls.each do |k, v|
                json = {"org_id" => @org.id, "content_provider_id" => @cp[k], "url" => "www." + v, "search_string" => search_string.degermatize}.to_json
                exchange.publish(json, :key => "google_slug")
              end
              json = {"org_id" => @org.id}.to_json #, "content_provider_id" => @cp[k], "url" => "www." + v ,"search_string" => search_string.degermatize}.to_json
              exchange.publish(json, :key => "bing_links")
                                                   #json2 = {"org_id" => @org.id}.to_json
                                                   #exchange.publish(json, :key => "foursquare")
            when "Ranks"
              exchange.publish(schedule.description, :key => "google_ranks")

            when /crawler.*/
              provider = item_name.split('.')[1]
              slug = @org.provider_slugs.where("content_provider_id = ?", @cp[provider.to_sym]).first
              json = {"org_id" => @org.id, "content_provider" => "#{provider}", "url" => slug.slug}.to_json unless slug.nil?
              exchange.publish(json, :key => "crawlers") unless slug.nil?
            when "geo"
              json = {"org_id" => @org.id}.to_json
              exchange.publish(json, :key => "geo")
            when "uptime_monitor"
              json = {"org_id" => @org.id, "url" => @org.url}.to_json
              exchange.publish(json, :key => "uptime_monitor")
            when "foursquare"
              fs_count = org.foursquare_venues.first.foursquare_counts.last rescue nil
              if fs_count
                if fs_count.created_at < Date.today
                  json = {"org_id" => @org.id}.to_json
                  exchange.publish(json, :key => "foursquare")
                end
              end
            when "TwitterCounts"
              #
            when "ShareCounter"
            when "alert_mail"
              #payload = schedule.description
              #json = {"org_id" => @org.id, "alert_text": alert_text, "email" => @org.email, "category_id" => category_id}.to_json
            when "aggregate"
              json = {"org_id" => @org.id}.to_json
              exchange.publish(json, :key => "aggregate")
            when "Competitors"
              poi = URI::encode(@org.city).to_s
              p = URI::encode(@org.category.name).to_s
              category_id = @org.category_id
              if @org.country_code_id == 228
                url = "http://local.yahoo.com/?search.html?cs=&vid=&p=#{p}&poi=#{poi}&yls-submit=Search"
            else
              url = "http://de.local.yahoo.com/?search.html?cs=&vid=&p=#{p}&poi=#{poi}&yls-submit=Suche"
            end
              json = {"org_id" => @org.id, "module_type" => "competitor", "content_provider" => "yahoo", "url" => url, "category_id" => category_id}.to_json
              exchange.publish(json, :key => "crawlers")
          end
          #if @ranktrigger == 1
          #  if @org.id == 99
          #    @keywords = Keyword.all
          #  else
          #    @organization = Organization.find(@org.id)
          #    @keywords = @organization.keywords
          #  end
          #  @keywords.each do |k|
          #    json = { "keyword_id" => k.id, "keyword" => k.name}.to_json
          #   # json2 = {"org_id" => @organization.id, "content_provider_id" => 6, "keyword" => k.id, "trials" => 5}.to_json
          #    exchange.publish(json, :key => "google_ranks")
          #    #exchange.publish(json2, :key => "ranks")
          #
          #  end
          #  @ranktrigger = 0
          #end
        end
      end
    end
    sleep 0.2
  end
end



