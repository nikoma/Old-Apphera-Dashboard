require 'uri'
require 'mechanize'
require 'logger'
require 'uuid'
require 'net/http'
require 'open-uri'


class HomePage
  @queue = :homepage_tasks

  def self.perform(org_id)
    @org = Organization.find(org_id)

    @url = "#{@org.url}" #customer_url

    logger = Logger.new ("log/get_homepage.log")

    totalproxies = Proxy.where(:bad => false).count
    random = rand(1+totalproxies)
    @choice =Proxy.limit(1).offset(random).where(:bad => false)
    @proxy = @choice[0]
    @agent = Mechanize.new
    @agent.user_agent_alias = "Mac Safari"
    @ip = @proxy.ip
    @port = @proxy.port.to_i
    @agent.set_proxy ''+@ip, @port


    def downloadHomePage
      u = uri
      @page = @agent.get(u)

      logger.info @page.body
    end

    private

    def uri
      URI.parse("http://#{@url}")
    end

    s = GetHomepageJob.new
    s.downloadHomePage

  end
end
