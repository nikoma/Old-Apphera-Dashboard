# encoding: utf-8
require 'rubygems'
require 'logger'
require_relative 'database.rb'
include Database

module Provider
 # sqs = RightAws::SqsGen2.new("Q","Z")
  def content_provider(cp)
    ContentProvider.cp(cp)
  end
  
  def proxy_ip
    Proxy.last.ip.to_s
    # write something which marks this proxy
  end
  def sqs
    RightAws::SqsGen2.new("Q","Z")
  end

end
