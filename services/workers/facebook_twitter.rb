require 'rubygems'
require 'mechanize'

class FacebookTwitter
  @queue = :GetHomePage

  def self.perform(organization_id)
    @org = Organization.find(organization_id)
    agent = Mechanize.new
    agent.user_agent_alias = "Mac Safari"
    page = agent.get("http://#{@org.url}")


    page.links.each do |link|
      puts link.uri
      if link.uri.to_s.include? ("facebook.com")
        puts "trying to write facebook"
        fb = FacebookUrl.new(:url => link.uri.to_s)
        @org.facebook_urls << fb
        @org.save
      end
      if link.uri.to_s.include? ("twitter.com")
        puts "trying to write twitter"
        tw = TwitterUrl.new(:url => link.uri.to_s)
        @org.twitter_urls << tw
        @org.save
      end
    end

  end
end
