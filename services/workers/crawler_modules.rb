require_relative File.dirname(__FILE__) + '/settings'
require_relative File.dirname(__FILE__) + '/../provider'
require_relative File.dirname(__FILE__) + '/german_month'
require_relative File.dirname(__FILE__) + '/fresh_proxy'
include GermanMonth
include FreshProxy
require 'rubygems'
require 'mechanize'

module CrawlerModules


end