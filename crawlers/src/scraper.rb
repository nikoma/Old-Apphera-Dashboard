#gem 'mechanize', '=1.0.0'
require 'mechanize'
require_relative 'apphera_api'
require_relative 'queue' unless ENV['DEVELOPMENT']
#require_relative 'proxy'
require_relative 'job'

class Scraper

  MONTHS = {
      # don't use this anymore
      :en => %w{foo January February March April May June July August September October November December},
      :de => %w{foo Januar February March April Mai Juni Juli August September Oktober November Dezember}
  }

  def month str
    case str
      when /^jan/i then 1
      when /^feb/i then 2
      when /^m(a|\xC3\xA4)r/ui then 3 # C3A4
      when /^apr/i then 4
      when /^ma[iy]/i then 5
      when /^jun/i then 6
      when /^jul/i then 7
      when /^aug/i then 8
      when /^sep/i then 9
      when /^o[ck]t/i then 10
      when /^nov/i then 11
      when /^de[cz]/i then 12
      else raise "unknown month: #str"
    end
  end

  def initialize job = nil
    # common initialization goes in the base class
    set_job job if job
    @agent = Mechanize.new
    @agent.user_agent_alias = "Windows IE 6"
    @agent.verify_mode = OpenSSL::SSL::VERIFY_NONE

#    change_proxy unless ENV["development"]
  end

#  def change_proxy
#    @proxy = Proxy.new
#    puts "Switching proxy to: #{@proxy.host}:#{@proxy.port}..."
#    @agent.set_proxy @proxy.host, @proxy.port
#  end

  def set_job job
    @job = job
    # here's where we include the provider specific scraper code
    job.module_type ||= "review"
    require_relative "modules/#{job.module_type}/#{job.provider}"
    self.class.class_eval("include #{job.provider.capitalize}")
  end

  def get url
    begin
      page = @agent.get(url)
    rescue => e
      case e.message
        when /connection refused/, /target machine actively refused/, /An existing connection was forcibly closed/, /host has failed to respond/, /An established connection was aborted/
          @proxy.disable({:module_type => @job.module_type, :provider => @job.provider}) if @proxy
          change_proxy
          return get url
        else raise e
      end
    end
    page
  end

  def run
    if !respond_to?('valid?') || valid?(@job.url)
      scrape @job.url
    else
      puts "invalid job url"
    end
  end

end
