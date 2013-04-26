#!ruby19
# encoding: utf-8
$LOAD_PATH.unshift File.dirname(__FILE__)

require_relative '../database.rb'
include Database
require_relative '../provider'
include Provider
require_relative '../sqs'
require 'rubygems'
require 'logger'
require 'settings'

class SelectProxy

  def proxy
    totalproxies = Proxy.where(:bad => false).count
    random = rand(1+totalproxies)
    @choice =Proxy.limit(1).offset(random).where(:bad => false)
    @proxy = @choice[0]
    @ip = @proxy.ip
    @port = @proxy.port.to_i
    return @ip, @port, @proxy.id
  end
  def bad(id)
    proxy = Proxy.find(id)
    proxy.bad = true
    proxy.save
  end

end
  
  
  
