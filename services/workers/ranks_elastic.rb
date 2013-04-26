#!ruby19
# -*- encoding : utf-8 -*-
require_relative File.dirname(__FILE__) + '/crawler_modules'
include CrawlerModules
require 'uuid'
require 'bunny'
require_relative 'settings'
require_relative 'apphera_api'
require 'rest-client'


class Hash

  def Hash.new_nested_hash
    Hash.new { |h, k| h[k]=Hash.new(&h.default_proc) }
  end

end

class Ranker
  attr_reader :agent, :page

  def initialize
    @proxy = JSON.parse(AppheraApi.new.proxy)
    @agent = Mechanize.new
    @agent.user_agent = "Windows IE7"
#    @agent.set_proxy(@proxy["ip"], @proxy["port"])
    @agent.cookie_jar.clear!
  end

  def search(q="Chinese restaurant san diego", job)
    u = uri

    u.query = "q=#{URI.escape(q)}" #{}"#{URI.escape(csz)}"
                                   #u.query = "p=Chinese&csz=Boston"
    begin
      @page = @agent.get(u)
        # rescue Errno::ETIMEDOUT, Timeout::Error, Net::HTTPNotFound
    rescue => e
   #   p "GOOGLE - Proxy is blocked: " + @proxy["ip"].to_s
      $exchange.publish(job.to_json, :key => "google_ranks")

    end
    begin
      @page = @page.form_with(:name => 'f').submit
    rescue
    end
  end

  def next_page
    begin
      @page = @page.link_with(:text => /Next/).click
    rescue
      @page = @page.link_with(:text => /Weiter/).click

    end

  end

  private

  def uri
    URI.parse("http://www.google.com")
  end

end
class RanksElastic
  include Settings
  b = Bunny.new(:host => HOST, :user => USER, :pass => PASS)
  b.start
  EXCHANGE = b.exchange("")
  $exchange = EXCHANGE
  QUEUE = b.queue("google_ranks")
  loop do
    job = JSON.parse(QUEUE.pop[:payload]) rescue nil
    if job
      #  p job
      @count = job["count"] || 0
      @count += 1
      if @count > 6
        EXCHANGE.publish(job.to_json, :key => "failed_jobs")
        break
      end
      @keyword_id = job["keyword_id"].to_i
      kw = job["keyword"]
      client = Ranker.new
      @kw = kw
      client.search(@kw, job)
      page = client.page
      # (1..2).each do |i|

      #filters = ["google", "bing", "live", "youtube", "msn", "microsoft"]
      res = []
      a = 0
      results = page.search('h3.r')
      results.each do |link|
        unless link.text.to_s.include? "Orte für"
          a += 1
          h = {} #Hash.new_nested_hash
                 #  p "the raw link : " + link.search('a').to_s
          h["ranking"] = a
          h["link_text"] = link.text.to_s
          h["link"] = link.search('a').to_s[/(?=http).*?(?=\&amp)/m]
          res << h
        end
      end
      # res.each do |r|
      #   p r
      #end
      #  p '---------------------'
      #   p "now comes json"

      #result_hash = Hash.new_nested_hash
      #result_hash["results"] = res
      json = res.to_json
      #p json
      #if res.length > 0
      #else
      p res
      if res.length > 0
        Ranking.create!(keyword_id: @keyword_id, ranks: json )
      else
        new_job = {keyword_id: @keyword_id, keyword: @kw, count: @count}.to_json
        p new_job
        EXCHANGE.publish(new_job, :key => "google_ranks")
      end


      duration = rand(1+5)
      sleep duration
      begin
        page = client.next_page #page.link_with(:text => "Next").click
      rescue
        #puts "end of list"
        break
      ensure
        #  #puts "ends here"
      end

    end
    sleep 2
  end
end

