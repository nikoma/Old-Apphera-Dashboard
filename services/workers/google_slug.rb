#!ruby19
# encoding: utf-8
require_relative File.dirname(__FILE__) + '/crawler_modules'
include CrawlerModules
require 'logger'
require 'uuid'
require 'mechanize'
require 'uri'
require 'net/http'
require 'open-uri'
require 'bunny'
require_relative 'apphera_api'

class GoogleSlug
  b = Bunny.new(:host => Settings::HOST, :user => Settings::USER, :pass => Settings::PASS)
  b.start
  EXCHANGE = b.exchange("")
  QUEUE = b.queue("google_slug")
  loop do
    job = JSON.parse(QUEUE.pop[:payload]) rescue nil

    if job
      org_id = job["org_id"].to_i
      attempts = 5 #job["trials"].to_i
      cp_id = job["content_provider_id"].to_i
      @org = Organization.find_by_id(org_id)
      @org_id = @org.id
      $attempts = attempts - 1
      @cp = ContentProvider.find(cp_id)
      @keyword = "#{@org.name}, #{@org.street}, #{@org.city}"
#      proxy =  JSON.parse(AppheraApi.new.proxy)
      @agent = Mechanize.new
      @agent.cookie_jar.clear!
      @agent.user_agent_alias = "Windows IE 7"
#      @agent.set_proxy(proxy["ip"],proxy["port"])
      begin
        @agent.get('http://google.com/') do |page|
          search_result = page.form_with(:name => 'f') do |search|
            search.q = 'site:' + @cp.url + ' ' + @keyword
            #puts 'site:' + @cp.url + ' ' + @keyword
          end.submit
          @content_provider_url = @cp.url
          rawmatch = search_result.link_with(:href => /http:\/\/#{@content_provider_url}/)
          if search_result.body.include? "Make sure all words are spelled correctly" # google shows that if there are no results
            break
          end
          @firstmatch = /(http)(.*?)(?=\&)/i.match(rawmatch.href)
          @newslug = @firstmatch[0]
          newslug = ProviderSlug.new(:organization_id => @org_id, :content_provider_id => cp_id, :slug => @newslug, :bad => false)
          newslug.save unless @newslug.include? "sitemap"

        end
      rescue => e
        p "Google slug could not be written: " + e.inspect
        #   if $attempts >= 1
        #Resque.enqueue(GoogleSlug, org_id, cp_id, $attempts)
      end
      # end
    end
    sleep 1
  end
end
